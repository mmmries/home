defmodule Home.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(HomeWeb.Endpoint, []),
      supervisor(DynamicSupervisor, [[strategy: :one_for_one, name: :zones_supervisor]]),
      worker(Registry, [[keys: :unique, name: :zones_registry]]),
    ]

    opts = [strategy: :one_for_one, name: Home.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    HomeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
