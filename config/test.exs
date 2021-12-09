import Config

config :hello, Hello.Repo, pool: Ecto.Adapters.SQL.Sandbox

config :logger, level: :warn

config :hello, Hello.Mailer, adapter: Swoosh.Adapters.Test
