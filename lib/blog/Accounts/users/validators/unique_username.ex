defmodule Blog.Accounts.Users.Validators.UniqueUsername do
  @moduledoc """
  This validator will ensure that the username provided is unique
  """

  use Vex.Validator

  alias Blog.Accounts.Users

  alias Vex.Validators.By

  def validate(username, _) do
    By.validate(username, function: &is_unique?/1, message: "username already taken")
  end

  defp is_unique?(username) do
    case Users.user_by_username(username) do
      nil -> true
      _ -> false
    end
  end
end
