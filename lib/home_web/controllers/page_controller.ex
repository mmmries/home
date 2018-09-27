defmodule HomeWeb.PageController do
  use HomeWeb, :controller

  def index(conn, _params) do
    zones = Home.Zones.get()
    render conn, "index.html", zones: zones
  end
end
