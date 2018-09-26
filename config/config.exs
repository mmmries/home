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

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
