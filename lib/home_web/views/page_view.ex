defmodule HomeWeb.PageView do
  use HomeWeb, :view

  def data(conn) do
    %{
      example_list: example_list(conn)
    }
  end

  def example_list(%{path_params: %{"id" => id}}) do
    zones = Home.Zones.get(id)
    lis = Enum.map(zones, fn(zone) ->
      "<li class=\"#{zone.status}\">#{zone.name}</li>"
    end) |> Enum.join()

    "<ul class='zones'>#{lis}</ul>"
    |> Floki.parse()
  end
end
