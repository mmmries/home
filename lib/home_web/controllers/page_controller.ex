defmodule HomeWeb.PageController do
  use HomeWeb, :controller
  import Texas.Controller

  def index(conn, _params) do
    conn
    |> texas_render("index.html", [texas: HomeWeb.PageView.data(conn)])
  end
end
