defmodule Home.Zones do
  use GenServer

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, nil, opts)
  end

  def get(pid \\ __MODULE__) do
    GenServer.call(pid, :get)
  end

  def handle_message(pid \\ __MODULE__, event, payload) do
    GenServer.call(pid, {:handle_message, event, payload})
  end

  def init(nil) do
    {:ok, %{zones: []}}
  end

  def handle_call(:get, _from, %{zones: zones}=state) do
    {:reply, zones, state}
  end

  def handle_call({:handle_message, "zone_status", %{"zones" => zones}}, _from, state) do
    zones = Home.Zone.parse(zones)
    {:reply, :ok, %{state | zones: zones}}
  end
end
