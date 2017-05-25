defmodule YtLogger.Repo.Migrations.AddGTokensToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :g_access_token, :string
      add :g_refresh_token, :string
    end
  end
end
