defmodule Blog.Accounts.Users.Events.UserRegistered do
  @moduledoc """
  Once the command `RegisterUser` has been processes successfully, this
  event will be generated
  """

  @derive [Jason.Encoder]
  @enforce_keys [:uuid, :username, :email, :hashed_password]
  defstruct [
    :uuid,
    :username,
    :email,
    :hashed_password
  ]
end
