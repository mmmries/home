defmodule HomeWeb.GarageDoorsController do
  use HomeWeb, :controller

  def index(conn, _params) do
    doors = Home.GarageDoors.get()
    render(conn, "index.html", [doors: doors, status: ""])
  end
end
