defmodule HomeWeb.GarageDoorsChannel do
  use Phoenix.Channel

  def join(_topic, _message, socket) do
    {:ok, socket}
  end

  def handle_in("door_status", %{"doors" => doors}, socket) do
    doors = Home.GarageDoor.parse(doors)
    reply = Home.GarageDoors.doors_update(doors)
    {:reply, reply, socket}
  end
end
