defmodule HomeWeb.PageCommander do
  use Drab.Commander
  require Logger

  onconnect :connected
  def connected(socket) do
    Phoenix.PubSub.subscribe(Home.PubSub, "sprinkler.zones")
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
    %{"id" => zone, "form" => form, "class" => class} = event
    %{"auth_token" => auth_token} = form
    case Home.Zones.send_command(type(class), zone, auth_token) do
      :ok ->
        socket |> poke(status: "...sent...")
      {:error, reason} ->
        socket |> poke(status: "Error: #{inspect(reason)}")
    end
  end

  defp type("on"), do: "turn_off"
  defp type("off"), do: "turn_on"
end
