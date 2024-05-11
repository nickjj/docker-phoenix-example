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
      test_coverage: [tool: ExCoveralls]
    ]
  end

  def application do
    [
      mod: {Hello.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:bandit, "1.5.2"},
      {:credo, "1.7.6", only: [:dev, :test], runtime: false},
      {:dns_cluster, "~> 0.1.3"},
      {:ecto_sql, "3.11.1"},
      {:excoveralls, "0.18.1", only: [:dev, :test]},
      {:finch, "0.18.0"},
      {:floki, "0.36.2", only: :test},
      {:gettext, "0.24.0"},
      {:heroicons, "0.5.5"},
      {:jason, "1.4.1"},
      {:phoenix, "1.7.12"},
      {:phoenix_ecto, "4.5.1"},
      {:phoenix_html, "4.1.1"},
      {:phoenix_live_dashboard, "0.8.3"},
      {:phoenix_live_reload, "1.5.3", only: :dev},
      {:phoenix_live_view, "0.20.14"},
      {:postgrex, "0.17.5"},
      {:swoosh, "1.16.5"},
      {:telemetry_metrics, "1.0.0"},
      {:telemetry_poller, "1.1.0"}
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
