defmodule Hello.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Hello.Repo,
      HelloWeb.Telemetry,
      {Phoenix.PubSub, name: Hello.PubSub},
      HelloWeb.Endpoint
      # Start a worker by calling: Hello.Worker.start_link(arg)
      # {Hello.Worker, arg}
    ]

    opts = [strategy: :one_for_one, name: Hello.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    HelloWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
