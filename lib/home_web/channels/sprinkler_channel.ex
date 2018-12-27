defmodule HomeWeb.SprinklerChannel do
  use Phoenix.Channel

  def join(_topic, _message, socket) do
    {:ok, socket}
  end

  def handle_in(event, %{"zones" => zones}, socket) do
    zones = Home.Zone.parse(zones)
    reply = Home.Zones.handle_update("mmmries", zones)
    {:reply, reply, socket}
  end
end
