# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :app_test,
  ecto_repos: [AppTest.Repo]

# Configures the endpoint
config :app_test, AppTestWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "5ZrdJTiidw+L3X8ZYrThGyU+Pr8vd1kj/TP9EbC0TtIh7nmuuPVEm9EKdKGi0hMm",
  render_errors: [view: AppTestWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: AppTest.PubSub,
  live_view: [signing_salt: "x1a/P6TG"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
