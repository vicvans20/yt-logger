defmodule YtLogger.Account.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias YtLogger.Account.User


  schema "account_users" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field :role, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :first_name, :last_name, :password_hash, :role])
    |> validate_required([:email])
  end
end
