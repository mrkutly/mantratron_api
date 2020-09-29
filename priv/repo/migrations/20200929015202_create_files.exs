defmodule MantratronApi.Repo.Migrations.CreateFiles do
  use Ecto.Migration

  def change do
    create table(:files) do
      add :uuid, :string
      add :duration, :integer
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:files, [:user_id])
    create index(:files, [:uuid])
  end
end
