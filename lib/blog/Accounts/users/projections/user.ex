defmodule Blog.Accounts.Users.Projections.User do
  @moduledoc """
  A projection is the current state for a given instance of an aggregate.

  Put another way, it means that it what the actual value of the aggregate is when all the
  events have been summed up upto the given point in time.

  Because of this property, it is used in the read model for querying. One thing to keep in mind
  is that, although our example here will use `use Ecto.Schema` to define a single
  projection; it does not mean that it is the only one.

  A projection module in Elixir (especially when using Ecto) is basically a normal definition of
  a schema that makes use of `use Ecto`. All we do is essentially flip the meaning and have it
  adopt a different meaning all together

  If we wished, we could define another projection for the user, with different fields and use that for
  a completely different query. Ecto makes this so much easy because of it's ability to define multiple
  schemas based of the same table.
  """

  use Ecto.Schema

  @type t :: %__MODULE__{}

  @primary_key {:uuid, :binary_id, autogenerate: false}
  schema "users" do
    field :bio, :string
    field :image, :string
    field :email, :string
    field :username, :string
    field :hashed_password, :string, redact: true

    timestamps()
  end
end
