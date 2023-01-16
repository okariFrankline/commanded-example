defmodule Blog.Accounts.Users do
  @moduledoc """
  This will act as the API for everything users
  """

  alias Blog.Accounts.Users.Queries.{UserByEmail, UserByUsername}
  alias Blog.Accounts.Users.Commands.RegisterUser
  alias Blog.Accounts.Users.Projections.User

  alias Blog.Repo

  alias Blogger.Application, as: Blogger

  @doc """
  Registers a new user
  """
  def register_user(attrs \\ %{}) do
    attrs
    |> assign_uuid()
    |> RegisterUser.new()
    |> Blogger.dispatch()
  end

  defp assign_uuid(attrs), do: Map.put(attrs, "uuid", Commanded.UUID.uuid4())

  @doc """
  Returns a user with a given username
  """
  @spec user_by_username(username :: String.t()) :: User.t() | nil
  def user_by_username(username) do
    username
    |> UserByUsername.new()
    |> Repo.one()
  end

  @doc """
  Returns a user with the given email address
  """
  @spec user_by_email(username :: String.t()) :: User.t() | nil
  def user_by_email(email) do
    email
    |> UserByEmail.new()
    |> Repo.one()
  end
end
