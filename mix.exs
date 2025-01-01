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
      {:bandit, "1.6.1"},
      {:credo, "1.7.11", only: [:dev, :test], runtime: false},
      {:dns_cluster, "~> 0.1.3"},
      {:ecto_sql, "3.12.1"},
      {:excoveralls, "0.18.3", only: [:dev, :test]},
      {:finch, "0.19.0"},
      {:floki, "0.37.0", only: :test},
      {:gettext, "0.26.2"},
      {:heroicons, "0.5.6"},
      {:jason, "1.4.4"},
      {:phoenix, "1.7.18"},
      {:phoenix_ecto, "4.6.3"},
      {:phoenix_html, "4.2.0"},
      {:phoenix_live_dashboard, "0.8.6"},
      {:phoenix_live_reload, "1.5.3", only: :dev},
      {:phoenix_live_view, "1.0.1"},
      {:postgrex, "0.19.3"},
      {:swoosh, "1.17.6"},
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
