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

  def registration_changeset(%User{} = user, attrs) do
    user
    |> changeset(attrs)
    |> cast(attrs, ~w(password)a, [])
    |> validate_length(:password, min: 6, max: 100)
    |> hash_password
  end

  defp hash_password(changeset) do
    IO.inspect changeset
    case changeset do
      %Ecto.Changeset{valid?: true,
                      changes: %{password: password}} ->
        put_change(changeset,
                   :password_hash,
                   Comeonin.Pbkdf2.hashpwsalt(password))
      _ ->
        changeset
    end
  end
end
