defmodule HomeWeb.PageController do
  use HomeWeb, :controller

  def index(conn, %{"id" => id}) do
    zones = Home.Zones.get(id)
    render(conn, "index.html", [zones: zones])
  end
end
