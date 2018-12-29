defmodule HomeWeb.GarageDoorsView do
  use HomeWeb, :view

  defp door_name_to_col_size("big") do
    "col-lg-6 col-md-6 col-sm-6"
  end
  defp door_name_to_col_size(_name) do
    "col-lg-3 col-md-3 col-sm-3"
  end
end
