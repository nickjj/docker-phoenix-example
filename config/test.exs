import Config

config :hello, Hello.Repo,
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: System.schedulers_online() * 2

config :logger, level: :warn

config :hello, Hello.Mailer, adapter: Swoosh.Adapters.Test
