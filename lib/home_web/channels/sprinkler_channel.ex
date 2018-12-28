defmodule HomeWeb.SprinklerChannel do
  use Phoenix.Channel

  def join(_topic, _message, socket) do
    {:ok, socket}
  end

  def handle_in("zone_status", %{"zones" => zones}, socket) do
    zones = Home.Zone.parse(zones)
    reply = Home.Zones.handle_update(zones)
    {:reply, reply, socket}
  end
end
