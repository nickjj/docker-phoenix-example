use Mix.Config

config :hello, Hello.Repo, pool: Ecto.Adapters.SQL.Sandbox

config :logger, level: :warn
