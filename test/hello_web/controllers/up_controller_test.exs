defmodule HelloWeb.UpControllerTest do
  use HelloWeb.ConnCase

  test "up loads", %{conn: conn} do
    conn = get(conn, Routes.up_path(conn, :index))
    assert html_response(conn, 200)
  end

  test "up databases loads", %{conn: conn} do
    conn = get(conn, Routes.up_path(conn, :databases))
    assert html_response(conn, 200)
  end
end
