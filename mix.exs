defmodule Hello.MixProject do
  use Mix.Project

  def project do
    [
      app: :hello,
      version: "0.1.0",
      elixir: "~> 1.13",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      build_path: "/mix/_build",
      deps_path: "/mix/deps",
      aliases: aliases(),
      deps: deps(),
      compilers: [:phoenix_live_view] ++ Mix.compilers(),
      listeners: [Phoenix.CodeReloader],
      test_coverage: [tool: ExCoveralls]
    ]
  end

  def application do
    [
      mod: {Hello.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  def cli do
    [
      preferred_envs: [precommit: :test]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:bandit, "1.8.0"},
      {:credo, "1.7.12", only: [:dev, :test], runtime: false},
      {:dns_cluster, "0.2.0"},
      {:ecto_sql, "3.13.2"},
      {:excoveralls, "0.18.5", only: [:dev, :test]},
      {:finch, "0.20.0"},
      {:floki, "0.38.0", only: :test},
      {:gettext, "0.26.2"},
      {:heroicons, "0.5.6"},
      {:jason, "1.4.4"},
      {:phoenix, "1.8.0"},
      {:phoenix_ecto, "4.6.5"},
      {:phoenix_html, "4.2.1"},
      {:phoenix_live_dashboard, "0.8.7"},
      {:phoenix_live_reload, "1.6.0", only: :dev},
      {:phoenix_live_view, "1.1.8"},
      {:postgrex, "0.21.1"},
      {:swoosh, "1.19.5"},
      {:telemetry_metrics, "1.1.0"},
      {:telemetry_poller, "1.3.0"}
    ]
  end

  defp aliases do
    [
      setup: ["deps.get", "ecto.setup", "cmd npm install --prefix assets"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"]
    ]
  end
end
