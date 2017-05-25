defmodule YtLogger.Repo.Migrations.CreateYtLogger.Account.User do
  use Ecto.Migration

  def change do
    create table(:account_users) do
      add :email, :string, null: false
      add :first_name, :string
      add :last_name, :string
      add :password_hash, :string
      add :role, :string, default: "general", null: false

      timestamps()
    end
    create unique_index(:account_users, [:email])

  end
end
