defmodule Home.GarageDoor do
  defstruct name: "small", status: :unknown

  def parse(string_maps) when is_list(string_maps) do
    Enum.map(string_maps, &parse/1)
  end

  def parse(map) when is_map(map) do
    %__MODULE__{
      name: map["name"],
      status: parse_status(map["status"]),
    }
  end

  defp parse_status("closed"), do: :closed
  defp parse_status("open"), do: :open
  defp parse_status("unknown"), do: :unknown
end
