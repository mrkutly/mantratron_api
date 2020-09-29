defmodule MantratronApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :password_reset_token, :string
    field :username, :string
    field :verified, :boolean, default: false
    field :verify_token, :string

    has_many(:files, MantratronApi.Audio.File)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :verified, :username, :password_reset_token, :password])
    |> put_password_hash()
    |> put_verify_token()
    |> validate_required([:email, :username, :verify_token, :password_hash])
  end

  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: pass}} = changeset)
       when not is_nil(pass) do
    put_change(changeset, :password_hash, Argon2.hash_pwd_salt(pass))
  end

  defp put_password_hash(changeset), do: changeset

  defp put_verify_token(%Ecto.Changeset{valid?: true} = changeset) do
    token = MantratronApi.Helpers.gen_token()
    put_change(changeset, :verify_token, token)
  end

  defp put_verify_token(changeset), do: changeset
end
