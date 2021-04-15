defmodule HelloWeb.ErrorViewTest do
  use HelloWeb.ConnCase, async: true

  import Phoenix.View

  test "renders 404.html" do
    assert render_to_string(HelloWeb.ErrorView, "404.html", []) == "Not Found"
  end

  test "renders 500.html" do
    assert render_to_string(HelloWeb.ErrorView, "500.html", []) ==
             "Internal Server Error"
  end
end
