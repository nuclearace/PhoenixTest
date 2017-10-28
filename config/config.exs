# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :ws,
  ecto_repos: [Ws.Repo]

# Configures the endpoint
config :ws, WsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "kFAx5f3QO7+Q3U1naL8fpDl7+zCHAA9KsRgbigH+rszt7JC82j5CBvhS3E4xN1o3",
  render_errors: [view: WsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Ws.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
