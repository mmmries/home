defmodule HomeWeb.PageCommander do
  use Drab.Commander
  require Logger

  onconnect :connected
  def connected(socket) do
    {:ok, id} = peek(socket, :id)
    Phoenix.PubSub.subscribe(Home.PubSub, "sprinklers.zones.#{id}")
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
end
