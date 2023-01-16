defmodule Blog.Accounts.Users.Router do
  @moduledoc """
  This router will be used to dispatch commands related to the `User`
  aggregate directly to the aggregate

  Seperated here in order to ensure the seperation of router concerns at the context level
  """

  use Commanded.Commands.Router

  alias Blog.Accounts.Users.Aggregates.User
  alias Blog.Accounts.Users.Commands.RegisterUser

  identify(User, by: :uuid)

  # Here we do not specify the function because the `User` aggregate
  # defines the `execute/2` function ( commanded knows to route to that
  # particular function)
  dispatch([RegisterUser], to: User)
end
