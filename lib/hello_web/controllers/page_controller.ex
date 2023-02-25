defmodule HelloWeb.PageController do
  use HelloWeb, :controller

  def home(conn, _params) do
    run_mode = if System.get_env("RELEASE_NAME"), do: "release", else: "mix"

    conn
    |> render(:home,
      run_mode: run_mode,
      phoenix_ver: Application.spec(:phoenix, :vsn),
      elixir_ver: System.version()
    )
  end
end
