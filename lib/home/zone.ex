defmodule Home.Zone do
  defstruct name: "", status: :off

  def parse(string_maps) when is_list(string_maps) do
    Enum.map(string_maps, &parse/1)
  end

  def parse(map) when is_map(map) do
    %__MODULE__{
      name: map["name"],
      status: parse_status(map["status"]),
    }
  end

  defp parse_status("off"), do: :off
  defp parse_status("on"), do: :on
end
