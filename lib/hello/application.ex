defmodule Hello.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      HelloWeb.Telemetry,
      Hello.Repo,
      {DNSCluster,
       query: Application.get_env(:hello, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Hello.PubSub},
      {Finch, name: Hello.Finch},
      HelloWeb.Endpoint
      # Start a worker by calling: Hello.Worker.start_link(arg)
      # {Hello.Worker, arg}
    ]

    opts = [strategy: :one_for_one, name: Hello.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    HelloWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
