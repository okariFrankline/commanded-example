defmodule Blog.Accounts.Supervisor do
  @moduledoc """
  This supervisor is responsible for supervising projectors for the Accounts context
  """

  use Supervisor

  alias Blog.Accounts.Users.Projectors

  @doc false
  def start_link(_) do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  @impl Supervisor
  def init(_) do
    children = [
      Projectors.User
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
