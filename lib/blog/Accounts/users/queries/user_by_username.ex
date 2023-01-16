defmodule Blog.Accounts.Users.Queries.UserByUsername do
  @moduledoc """
  This query has the single responsibility of returning a query that
  represents a given user who has the given username
  """

  import Ecto.Query, only: [where: 3]

  alias Blog.Accounts.Users.Projections.User

  def new(username) do
    where(User, [u], u.username == ^username)
  end
end
