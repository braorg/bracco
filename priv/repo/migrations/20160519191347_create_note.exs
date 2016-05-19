defmodule Bracco.Repo.Migrations.CreateNote do
  use Ecto.Migration

  def change do
    create table(:notes) do
      add :title, :string, size: 100
      add :description, :text
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps
    end
    create index(:notes, [:user_id])

  end
end
