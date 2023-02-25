defmodule HelloWeb.PageHTML do
  @moduledoc false

  use HelloWeb, :html

  embed_templates "page_html/*"
end
