defmodule Home.Zones do
  use GenServer

  def start_link(nil, opts \\ [name: __MODULE__]) do
    GenServer.start_link(__MODULE__, nil, opts)
  end

  def handle_update(zones) do
    GenServer.call(__MODULE__, {:zone_update, zones})
  end

  def get() do
    GenServer.call(__MODULE__, :get)
  end

  def response_status(message) do
    Phoenix.PubSub.broadcast(Home.PubSub, "sprinkler.zones", {:response_status, message})
  end

  @spec send_command(String.t(), String.t(), String.t()) :: :ok | {:error, term()}
  def send_command(command, zone, auth_token) do
    HomeWeb.Endpoint.broadcast("sprinkler", "command", %{"zone" => zone, "auth_token" => auth_token, "type" => command})
  end

  def init(nil) do
    {:ok, %{zones: []}}
  end

  def handle_call(:get, _from, %{zones: zones}=state) do
    {:reply, zones, state}
  end

  def handle_call({:zone_update, zones}, _from, state) do
    Phoenix.PubSub.broadcast(Home.PubSub, "sprinkler.zones", {:zone_update, zones})
    {:reply, :ok, %{state | zones: zones}}
  end
end
