# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :blog,
  ecto_repos: [Blog.Repo],
  event_stores: [Blog.EventStore]

# Configures the endpoint
config :blog, BlogWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [json: BlogWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Blog.PubSub,
  live_view: [signing_salt: "H+t1r74A"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# commande Blog.App configuration
config :blog, Blogger.Application,
  event_store: [
    adapter: Commanded.EventStore.Adapters.EventStore,
    event_store: Blog.EventStore
  ],
  pubsub: :local,
  registry: :local

config :vex,
  sources: [
    Blog.Accounts.Users.Validators,
    Vex.Validators
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
