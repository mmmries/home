defmodule Home.ZoneTest do
  use ExUnit.Case, async: true
  alias Home.Zone

  test "parsing zones" do
    parsed = Zone.parse([
    %{
      "name"   => "zone1",
      "status" => "on",
    },
    %{
      "name"   => "zone2",
      "status" => "off",
    },
    %{
      "name"   => "zone3",
      "status" => "off",
    },
    %{
      "name"   => "zone4",
      "status" => "off",
    }])
    assert parsed == [
      %Zone{name: "zone1", status: :on},
      %Zone{name: "zone2", status: :off},
      %Zone{name: "zone3", status: :off},
      %Zone{name: "zone4", status: :off},
    ]
  end
end
