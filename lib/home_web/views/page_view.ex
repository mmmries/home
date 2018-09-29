defmodule HomeWeb.PageView do
  use HomeWeb, :view

  def data(conn) do
    %{
      example_list: example_list(conn)
    }
  end

  def example_list(_conn) do
    zones = Home.Zones.get()
    lis = Enum.map(zones, fn(zone) ->
      "<li class=\"#{zone.status}\">#{zone.name}</li>"
    end) |> Enum.join()

    "<ul class='zones'>#{lis}</ul>"
    |> Floki.parse()
  end
end
