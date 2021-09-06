defmodule Hello.MixProject do
  use Mix.Project

  def project do
    [
      app: :hello,
      version: "0.1.0",
      elixir: "~> 1.11",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
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
      {:credo, "1.5.6", only: [:dev, :test], runtime: false},
      {:ecto_sql, "3.7.0"},
      {:excoveralls, "0.14.2", only: [:dev, :test]},
      {:floki, ">= 0.31.0", only: :test},
      {:gettext, "0.18.2"},
      {:jason, "1.2.2"},
      {:phoenix, "1.5.12"},
      {:phoenix_ecto, "4.4.0"},
      {:phoenix_html, "3.0.3"},
      {:phoenix_live_dashboard, "0.5.0"},
      {:phoenix_live_reload, "1.3.3", only: :dev},
      {:phoenix_live_view, "0.16.3"},
      {:plug_cowboy, "2.5.1"},
      {:postgrex, ">= 0.0.0"},
      {:telemetry_metrics, "0.6.1"},
      {:telemetry_poller, "0.5.1"}
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
