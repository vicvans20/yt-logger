defmodule YtLogger.Repo.Migrations.DropAccountUsers do
  use Ecto.Migration

  def change do
    drop table(:account_users)
  end
end
