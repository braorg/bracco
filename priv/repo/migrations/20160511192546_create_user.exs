defmodule Bracco.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string, size: 50
      add :last_name, :string, size: 50
      add :email, :string, size: 50
      add :avatar_url, :string, size: 100
      add :username, :string, size: 50
      add :password_hash, :string
      add :profile_id, references(:profiles)

      timestamps
    end

    create index(:users, [:profile_id])
    create unique_index(:users, [:username])

  end
end
