defmodule Blog.Accounts.Users.Validators.UniqueEmail do
  @moduledoc """
  Validates to ensure that the email address is unique
  """

  use Vex.Validator

  alias Blog.Accounts.Users

  alias Vex.Validators.By

  def validate(email, _) do
    By.validate(email, function: &is_unique?/1, message: "email has already been taken")
  end

  defp is_unique?(email) do
    case Users.user_by_email(email) do
      nil -> true
      _ -> false
    end
  end
end
