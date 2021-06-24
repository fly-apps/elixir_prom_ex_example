# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :todo_list, TodoListWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "1SbOfdetoi6ZPv6qCCzSwzB3eK0GpFPehEI6n+Rxpqk9LuozAjL8CW4uAKy4t/o5",
  render_errors: [view: TodoListWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: TodoList.PubSub,
  live_view: [signing_salt: "kEdiODvK"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
