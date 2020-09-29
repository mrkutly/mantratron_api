# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :mantratron_api,
  ecto_repos: [MantratronApi.Repo]

# Configures the endpoint
config :mantratron_api, MantratronApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "NfPhQ4NVMBR1uGn8m1m0AROHIbR5UDNbp2dx5ITe8GrkxMe47bYj5+/wvjKGuvgD",
  render_errors: [view: MantratronApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: MantratronApi.PubSub,
  live_view: [signing_salt: "MuMVgD8v"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :ex_aws,
  json_codec: Jason,
  access_key_id: [{:system, "AWS_ACCESS_KEY_ID"}, :instance_role],
  secret_access_key: [{:system, "AWS_SECRET_ACCESS_KEY"}, :instance_role]
