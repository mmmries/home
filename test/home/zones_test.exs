defmodule Home.ZonesTest do
  use ExUnit.Case, async: true
  alias Home.{Zone,Zones}

  test "it can provide a list of zones with their current status" do
    {:ok, pid} = Zones.start_link()
    Zones.handle_message(pid, "zone_status", %{"zones" => [
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
      },
    ]})

    assert Zones.get(pid) == [
      %Zone{name: "zone1", status: :on},
      %Zone{name: "zone2", status: :off},
      %Zone{name: "zone3", status: :off},
      %Zone{name: "zone4", status: :off},
    ]
  end
end
