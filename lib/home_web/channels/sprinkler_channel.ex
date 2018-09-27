defmodule HomeWeb.SprinklerChannel do
  use Phoenix.Channel

  def join(_topic, _message, socket) do
    {:ok, socket}
  end

  def handle_in(event, payload, socket) do
    reply = Home.Zones.handle_message(event, payload)
    {:reply, reply, socket}
  end
end
