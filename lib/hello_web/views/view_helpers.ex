defmodule HelloWeb.ViewHelpers do
  @moduledoc """
  Convenience functions for your templates.
  """

  use HelloWeb, :view

  def flash_class(type) do
    case type do
      "info" ->
        "bg-blue-700"

      "success" ->
        "bg-green-700"

      "warn" ->
        "bg-yellow-700"

      "error" ->
        "bg-red-700"

      _ ->
        "bg-gray-700"
    end
  end
end
