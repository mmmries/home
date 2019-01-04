defmodule Home.GarageDoors do
  use GenServer
  require Logger
  alias Home.GarageDoor

  def start_link(doors, opts \\ [name: __MODULE__]) do
    GenServer.start_link(__MODULE__, doors, opts)
  end

  @spec get(GenServer.server()) :: list(GarageDoor.t())
  def get(name_or_pid \\ __MODULE__) do
    GenServer.call(name_or_pid, :get)
  end

  @spec doors_update(GenServer.server(), list(GarageDoor.t())) :: :ok
  def doors_update(server \\ __MODULE__, doors) do
    GenServer.call(server, {:doors_update, doors})
  end

  @spec send_command(String.t(), String.t(), String.t()) :: :ok | {:error, term()}
  def send_command(command, door, auth_token) do
    Logger.info "#{__MODULE__} sending command #{command} to #{door}"
    HomeWeb.Endpoint.broadcast("garage_doors", "command", %{"door" => door, "auth_token" => auth_token, "type" => command})
  end

  @impl GenServer
  def init(doors) do
    {:ok, %{doors: doors}}
  end

  @impl GenServer
  def handle_call(:get, _from, %{doors: doors}=state) do
    {:reply, doors, state}
  end
  def handle_call({:doors_update, doors}, _from, state) do
    Phoenix.PubSub.broadcast(Home.PubSub, "garage_doors.ui", {:doors_update, doors})
    door_change(state.doors, doors)
    {:reply, :ok, %{state | doors: doors}}
  end

  defp door_change(doors, doors), do: :no_op
  defp door_change(_old_doors, new_doors) do
    message = new_doors
              |> Enum.map(fn(%GarageDoor{}=door) -> "#{door.name}: #{door.status}" end)
              |> Enum.join("\n")
    Home.Notification.send_to_all_subscribed("Garage Doors", message)
  end
end
