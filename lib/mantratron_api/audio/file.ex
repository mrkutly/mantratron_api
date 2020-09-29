defmodule MantratronApi.Audio.File do
  use Ecto.Schema
  import Ecto.Changeset

  schema "files" do
    field :duration, :integer
    field :url, :string

    belongs_to(:user, MantratronApi.Accounts.User)

    timestamps()
  end

  @doc false
  def changeset(file, attrs) do
    file
    |> cast(attrs, [:url, :duration])
    |> validate_required([:url, :duration])
  end
end
