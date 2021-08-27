# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :abs_fed, AbsFedWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "oVoW/pjSywH2qiZk3RcosuDHsHa0T13xfoLka6Pb0/QZbStxD8qTwg2mjns9Qbho",
  render_errors: [view: AbsFedWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: AbsFed.PubSub,
  live_view: [signing_salt: "HeFD/i0H"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
