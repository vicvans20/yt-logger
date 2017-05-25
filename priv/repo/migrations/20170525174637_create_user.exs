defmodule YtLogger.Repo.Migrations.CreateYtLogger.User do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :first_name, :string
      add :last_name, :string
      add :password, :string
      add :role, :string, default: "general", null: false

      timestamps()
    end
    create unique_index(:users, [:email])

  end
end