defmodule Blog.Accounts.Users.Validators.Uuid do
  @moduledoc """
  This module is a custom validator for validating that a given uuid is valid

  How will it work?
  -----------------

  - In order for this to work, it needs to be added in configuration for vex under the `:sources` key
  - Afterwards, anytime we need this to work, we are going to need add `uuid: true` as part of the
    options when using `vzlidate/2`

  Example
  ------

  defmodule Some.Module do
    defstruct [:uuid, :name]

    use Vex.Struct

    validates :uuid, presence: [message: "cannot be empty"], uuid: true
  end

  => Now, everytime validation for uuid happens, this module will be callled
  """

  use Vex.Validator

  @doc """
  Because we are doing `use Vex.Validator`, it means that this modules
  must implement the function `validate/2` which takes two argumenents

  1. the value to be validated
  2. A list of options
  """
  def validate(value, _) do
    Vex.Validators.By.validate(value,
      function: &valid_uuid/1,
      allow_nil: false,
      allow_blank: false
    )
  end

  defp valid_uuid(value) do
    case UUID.info(value) do
      {:ok, _} -> true
      {:error, _} -> false
    end
  end
end
