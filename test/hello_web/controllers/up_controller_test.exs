defmodule HelloWeb.UpControllerTest do
  use HelloWeb.ConnCase

  test "up loads", %{conn: conn} do
    conn = get(conn, ~p"/up")
    assert html_response(conn, 200)
  end

  test "up databases loads", %{conn: conn} do
    conn = get(conn, ~p"/up/databases")
    assert html_response(conn, 200)
  end
end
