defmodule MantratronApi.Audio.File do
  use Ecto.Schema
  import Ecto.Changeset

  schema "files" do
    field :duration, :integer
    field :uuid, :string

    belongs_to(:user, MantratronApi.Accounts.User)

    timestamps()
  end

  @doc false
  def changeset(file, attrs) do
    file
    |> cast(attrs, [:uuid, :duration])
    |> validate_required([:uuid, :duration])
  end
end
