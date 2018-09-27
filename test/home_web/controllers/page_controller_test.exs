defmodule HomeWeb.PageControllerTest do
  use HomeWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Zones"
  end
end
