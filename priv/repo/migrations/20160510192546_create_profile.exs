defmodule Bracco.Repo.Migrations.CreateProfile do
  use Ecto.Migration

  def change do
    create table(:profiles) do
      add :description, :string, size: 20

      timestamps
    end
  end
end
