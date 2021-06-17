import Config

if config_env() == :prod do
  secret_key_base =
    System.get_env("SECRET_KEY_BASE") ||
      raise """
      environment variable SECRET_KEY_BASE is missing.
      You can generate one by calling: mix phx.gen.secret
      """

  app_name = System.get_env("FLY_APP_NAME") || raise "FLY_APP_NAME is required"

  config :todo_list, TodoListWeb.Endpoint,
    server: true,
    url: [host: "#{app_name}.fly.dev", port: 80],
    http: [
      port: String.to_integer(System.get_env("PORT") || "4000"),
      transport_options: [socket_opts: [:inet6]]
    ],
    secret_key_base: secret_key_base

  config :todo_list, TodoList.PromEx,
    manual_metrics_start_delay: :no_delay,
    grafana: [
      host: System.get_env("GRAFANA_HOST") || raise("GRAFANA_HOST is required"),
      auth_token: System.get_env("GRAFANA_TOKEN") || raise("GRAFANA_TOKEN is required"),
      upload_dashboards_on_start: true,
      folder_name: "Todo App Dashboards",
      annotate_app_lifecycle: true
    ]
end
