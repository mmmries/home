defmodule HomeWeb.PageCommander do
  use Drab.Commander
  require Logger

  onconnect :connected
  def connected(socket) do
    {:ok, id} = peek(socket, :id)
    Phoenix.PubSub.subscribe(Home.PubSub, "sprinkler.zones.#{id}")
    zone_update_loop(socket)
  end

  defp zone_update_loop(socket) do
    receive do
      {:zone_update, zones} -> poke(socket, zones: zones)
      other ->
        Logger.error("#{__MODULE__} received unexpected message #{inspect(other)}")
    end
    zone_update_loop(socket)
  end

  defhandler toggle(socket, event) do
    {controller, command} = build_command(event) |> IO.inspect()
    case Home.Zones.send_command(controller, command) do
      %{"status" => 200} ->
        socket |> poke(status: "👍")
      %{"message" => message} ->
        socket |> poke(status: "Error: #{message}")
    end
  end

  defp build_command(%{"id" => zone, "form" => form, "class" => class}) do
    %{"controller" => controller, "auth_token" => auth_token} = form
    msg = %{type: type(class), zone: zone, auth_token: auth_token}
    {controller, msg}
  end

  defp type("on"), do: "turn_off"
  defp type("off"), do: "turn_on"
end
