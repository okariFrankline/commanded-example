defmodule Blog.Accounts.Users.Commands.RegisterUser do
  @moduledoc """
  Defines the command for registering a user

  In this module, we will be using vex for validation as it allows for validating of structs
  easily

  Alternatively, we could just as easily use Ecto.Changeset to do the validation

  So which one should you use?
  ----------------------------

  I believe that the decision boils down to what the team decides and which one is easier to follow
  """

  defstruct [
    :uuid,
    :email,
    :username,
    :password,
    :hashed_password
  ]

  use ExConstructor

  # addition of this allows us to do validation on the command using the Vex library
  use Vex.Struct

  # How does Vex work?

  # - When validating structs, vex allows us to make use of 'use Vex.Struct', which
  #   exports the macro `validates/2`

  #   This accepts two arguments: the field to validate and options

  # - There are a number of options that can be passed ( available in the docs), but
  #   an important one to keep note of is the ability to do custom validation

  #   Custom validation makes it possible to make well, custom validations 😅
  validates(:uuid, presence: [message: "cannot be empty"], uuid: true)

  validates(:username, presence: [message: "cannot be empty"], string: true, unique_username: true)

  validates(:password, presence: [message: "cannot be empty"], string: true)

  validates(:email, presence: [message: "cannot be empty"], string: true, unique_email: true)
end
