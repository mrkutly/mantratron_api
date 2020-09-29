defmodule MantratronApi.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :verified, :boolean, default: false, null: false
      add :username, :string, null: false
      add :verify_token, :string
      add :password_reset_token, :string
      add :password_hash, :string, null: false

      timestamps()
    end

    create unique_index(:users, :email)
    create unique_index(:users, :username)
  end
end
