defmodule Blog.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :bio, :text
      add :email, :string
      add :image, :string
      add :username, :string
      add :hashed_password, :string
      add :uuid, :uuid, primary_key: true

      timestamps()
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:username])
  end
end
