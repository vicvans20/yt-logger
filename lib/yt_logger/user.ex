defmodule YtLogger.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias YtLogger.User


  schema "users" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :password_virtual, :string, virtual: true
    field :password, :string
    field :role, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :first_name, :last_name, :password, :role])
    |> validate_required([:email])
  end
end
