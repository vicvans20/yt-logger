# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :yt_logger,
  ecto_repos: [YtLogger.Repo]

# Configures the endpoint
config :yt_logger, YtLogger.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "IrPFQ1d2VzscvAP3g2AQ5o+JNtYrgamUwb7Vvxt1wlq20sqph9euPzG69e1rKe85",
  render_errors: [view: YtLogger.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: YtLogger.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
