defmodule HelloWeb.Layouts do
  @moduledoc false

  use HelloWeb, :html

  embed_templates "layouts/*"
end
