defmodule Blogger.Application do
  @moduledoc """
  This module defines the Commanded.Application app that will be used as the main application
  within the system.

  It should not be confused with `Blog.Application`, which starts the application.

  Even though it's called Blog.App, it's started within the `Blog.Application` supervision tree
  """

  use Commanded.Application, otp_app: :blog

  alias Blog.Accounts.Users

  router(Users.Router)
end
