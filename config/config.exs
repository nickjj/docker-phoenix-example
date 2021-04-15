use Mix.Config

config :hello,
  ecto_repos: [Hello.Repo]

config :hello, HelloWeb.Endpoint,
  # Enable both ipv4 and ipv6 on all interfaces. By the way, the port is
  # configured with an environment variable and it's in the runtime.exs config.
  http: [ip: {0, 0, 0, 0, 0, 0, 0, 0}],
  render_errors: [
    view: HelloWeb.ErrorView,
    accepts: ~w(html json),
    layout: false
  ],
  pubsub_server: Hello.PubSub

config :hello, Hello.Repo, adapter: Ecto.Adapters.Postgres

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{Mix.env()}.exs"
