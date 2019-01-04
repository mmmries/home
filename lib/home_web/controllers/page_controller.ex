defmodule HomeWeb.PageController do
  use HomeWeb, :controller

  def home(conn, _params) do
    conn |> redirect(to: "/garage_doors")
  end
  def index(conn, _params) do
    zones = Home.Zones.get()
    render(conn, "index.html", [zones: zones, status: ""])
  end
end
