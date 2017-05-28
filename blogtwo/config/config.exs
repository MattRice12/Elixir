# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :blogtwo,
  ecto_repos: [Blogtwo.Repo]

# Configures the endpoint
config :blogtwo, Blogtwo.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "XjNqBs8u4XvqJLrl6RiS6KYqF1se7flPkKR8nAWi18jTZfZqs0rD7sEBkROYigV6",
  render_errors: [view: Blogtwo.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Blogtwo.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
