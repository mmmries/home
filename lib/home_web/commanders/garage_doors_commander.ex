defmodule HomeWeb.GarageDoorsCommander do
  use Drab.Commander
  require Logger

  onconnect :connected
  def connected(socket) do
    Phoenix.PubSub.subscribe(Home.PubSub, "garage_doors.ui")
    doors_update_loop(socket)
  end

  defp doors_update_loop(socket) do
    receive do
      {:doors_update, doors} -> poke(socket, doors: doors)
      {:response_status, message} -> poke(socket, status: message)
      other ->
        Logger.error("#{__MODULE__} received unexpected message #{inspect(other)}")
    end
    doors_update_loop(socket)
  end
end
