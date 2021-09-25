defmodule Hello.Mailer do
  @moduledoc """
  This module defines Swoosh for your application.
  """

  use Swoosh.Mailer, otp_app: :hello
end
