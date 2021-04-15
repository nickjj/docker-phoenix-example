use Mix.Config

config :hello, HelloWeb.Endpoint,
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [],
  live_reload: [
    patterns: [
      ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"priv/gettext/.*(po)$",
      ~r"lib/hello_web/(live|views)/.*(ex)$",
      ~r"lib/hello_web/templates/.*(eex)$"
    ]
  ]

config :hello, Hello.Repo, show_sensitive_data_on_connection_error: true

config :logger, :console, format: "[$level] $message\n"

config :phoenix, :stacktrace_depth, 20
config :phoenix, :plug_init_mode, :runtime
