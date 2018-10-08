defmodule Home.Zones do
  use GenServer
  @registry :zones_registry
  @supervisor :zones_supervisor

  def start_link(name, opts \\ []) do
    GenServer.start_link(__MODULE__, name, opts)
  end

  def accept_update(%{body: body, topic: topic}) do
    %{"zones" => zones} = Jason.decode!(body)
    zones = Home.Zone.parse(zones)
    [_, _, name] = String.split(topic, ".")
    {:ok, pid} = ensure_running(name)
    GenServer.call(pid, {:zone_update, zones})
  end

  def ensure_running(name) do
    case Registry.lookup(@registry, name) do
      [] ->
        DynamicSupervisor.start_child(@supervisor, {Home.Zones, name})
      [{pid,_}] ->
        {:ok, pid}
    end
  end

  def get(name) do
    GenServer.call({:via, Registry, {@registry, name}}, :get)
  end

  def send_command(controller, command) do
    topic = "sprinkler.commands.#{controller}"
    case Gnat.request(:gnat, topic, Jason.encode!(command), receive_timeout: 5_000) do
      {:ok, %{body: body}} ->
        Jason.decode!(body)
      {:error, :timeout} ->
        %{"status" => 502, "message" => "timed out waiting for a response"}
    end
  end

  def init(name) do
    Registry.register(@registry, name, self())
    {:ok, %{name: name, zones: []}}
  end

  def handle_call(:get, _from, %{zones: zones}=state) do
    {:reply, zones, state}
  end

  def handle_call({:zone_update, zones}, _from, %{name: name}=state) do
    Phoenix.PubSub.broadcast(Home.PubSub, "sprinkler.zones.#{name}", {:zone_update, zones})
    {:reply, :ok, %{state | zones: zones}}
  end
end
