defmodule Blog.Accounts.Users.Queries.UserByEmail do
  @moduledoc """
  Returns the user with the provided email address
  """

  import Ecto.Query, only: [where: 3]

  alias Blog.Accounts.Users.Projections.User

  @doc """
  Returns query with the given email address
  """
  @spec new(email :: String.t()) :: Ecto.Query.t()
  def new(email) do
    where(User, [u], u.email == ^email)
  end
end
