defmodule Home.ZonesTest do
  use ExUnit.Case, async: true
  alias Home.{Zone,Zones}

  @zones_name "test"

  test "it can provide a list of zones with their current status" do
    body = Jason.encode!(%{"zones" => [
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
    msg = %{body: body, topic: "sprinkler.zones.#{@zones_name}"}
    Home.Zones.accept_update(msg)

    assert Zones.get(@zones_name) == [
      %Zone{name: "zone1", status: :on},
      %Zone{name: "zone2", status: :off},
      %Zone{name: "zone3", status: :off},
      %Zone{name: "zone4", status: :off},
    ]
  end
end
