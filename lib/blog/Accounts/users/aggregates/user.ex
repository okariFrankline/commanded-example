defmodule Blog.Accounts.Users.Aggregates.User do
  @moduledoc """
  This is instance module for a given user aggregate and will be used to execute
  commands as well as rebuild the state of the instance
  """

  defstruct [
    :uuid,
    :bio,
    :email,
    :image,
    :username,
    :hashed_password
  ]

  alias Blog.Accounts.Users.Commands.RegisterUser
  alias Blog.Accounts.Users.Events.UserRegistered

  ## Public API

  @doc """
  The `execute/2` function is named so for one main reason:
    => It allows Commanded to dispatch directly to the aggregate module
      without needing a custom handler.

  While this function could be named anything and taking any number of arguments,
  doing so would mean that we need to define a command handler that routes to the said
  function (doable but a lot of hustle 😊)

  Whatever the case, the function that handles a command must return a domain event after
  successful completion of executing the command. This function can return one of the following
  on success:
    1. event :: struct()
    2. events :: [struct()]
    3. {:ok, event :: struct()}
    4. {:ok, events :: [structs]}

  In case of an error, it can return {:error, term()}
  """
  def execute(%__MODULE__{uuid: nil}, %RegisterUser{} = cmd) do
    %UserRegistered{
      uuid: cmd.uuid,
      email: cmd.email,
      username: cmd.username,
      hashed_password: cmd.hashed_password
    }
  end

  def execute(_, _), do: {:error, :user_already_exists}

  ## State mutators

  @doc """
  The `apply/2` function in the aggregate is used to rebuild the aggregate from
  all the events that have already happened ( and ideally already stored in an event store)

  One thing to keep in mind is that this function cannot fail at any given point in time
  because once an event has already happened, it cannot be rejected ( the rationale behind this
  is that an event that happened in the past cannot be undone as it's recorded as a fact)
  """
  def apply(%__MODULE__{} = state, %UserRegistered{} = evt) do
    %__MODULE__{
      state
      | uuid: evt.uuid,
        email: evt.email,
        username: evt.username,
        hashed_password: evt.hashed_password
    }
  end
end
