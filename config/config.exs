# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :home, HomeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "t2fooBiCKzIo8D5XOH5dmt/h6ulDuMGfcD/X/xX8zFZwHLZeSBcG4U6eFDU5sVSK",
  render_errors: [view: HomeWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Home.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

config :home, :gnat_connection, %{
    name: :gnat,
    connection_settings: [
      %{host: 'nats.riesd.com', port: 4223, tls: true, username: System.get_env("NATS_USER"), password: System.get_env("NATS_PASS")},
    ]
  }

config :home, :gnat_consumer, %{
    connection_name: :gnat,
    consuming_function: {Home.Zones, :accept_update},
    subscription_topics: [
      %{topic: "sprinkler.zones.*", queue_group: "home.riesd.com"},
    ],
  }

config :texas, pubsub: HomeWeb.Endpoint
config :texas, router: HomeWeb.Router
config :phoenix, :template_engines,
  tex:  Texas.TemplateEngine


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
