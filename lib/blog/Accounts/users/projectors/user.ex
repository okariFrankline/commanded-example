defmodule Blog.Accounts.Users.Projectors.User do
  @moduledoc """
  If a projection is the current state for an aggregate instance, the the projector is a process
  that is used to actually perfom the actual projection

  By projection, we mean that it takes an event that has already happened and updates the read model
  to reflect the changes that have occured.

  Examples
  --------

  Imagine that the event `UserRegistered` has taken place within the system.

  What a projector process will do is to read this event from the EventStore and then perform an update to
  read model db by inserting the user into the database.

  In our case, the projector will perfrom a Repo.insert to add the user to the db, hence updating the read model

  NOTE:

    1. By default, projection is asynchronous, hence may lead to eventual consitency issues (Keep this in mind
      as the read model may still be stale for some time as the handler for the event takes place)

    2. Every projector is a process that must be supervised and started in a supervisor tree

  In this application, we will use the library `Commanded.Projections.Ecto` to define projectors for our projections
  The library abstracts away most of the creation of handlers and Ecto.Multi calls by providing a DSL that makes
  projection easy.

  In order to define a projector, a module must make use of `use Commanded.Projections.Ecto, application: app, repo: repo`

  NOTE:

    The `:application` option is not the name of the app, but the module that implements `use Commanded.Application`
  """

  use Commanded.Projections.Ecto,
    repo: Blog.Repo,
    application: Blogger.Application,
    name: "Accounts.Users.Projectors.User"

  alias Blog.Accounts.Users.Events.UserRegistered
  alias Blog.Accounts.Users.Projections.User

  alias Ecto.Multi

  # If an event has taken place within the application, `Commanded.Projections.Ecto`
  # makes it easy to project an event using the `project/2/3` macro.
  # The macro takes the following arguments:
  # 1. The Event that took place
  # 2. Metadata (optional)
  # 3. One arity function that recieves an Ecto.Multi struct
  # In our case, when a user is registered and the event UserRegistered is emitted,
  # it will result in the user being inserted into the db
  project(%UserRegistered{} = evt, fn multi ->
    Multi.insert(multi, :user, new_user(evt))
  end)

  defp new_user(evt) do
    %User{
      bio: nil,
      image: nil,
      uuid: evt.uuid,
      email: evt.email,
      username: evt.username,
      hashed_password: evt.hashed_password
    }
  end
end
