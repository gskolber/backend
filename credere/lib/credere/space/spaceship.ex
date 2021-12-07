defmodule Credere.Space.Spaceship do
  use Ecto.Schema
  import Ecto.Changeset

  schema "spaceships" do
    field :face, :string, default: "right", required: true
    field :x_cordinate, :integer, default: 0, required: true
    field :y_cordinate, :integer, default: 0, required: true
    field :game_session, :string

    timestamps()
  end

  @doc false
  def changeset(spaceship, attrs \\ %{}) do
    spaceship
    |> cast(attrs, [:game_session])
    |> validate_required([:game_session])
  end

  def new_cordinates_changeset(spaceship, attrs) do
    spaceship
    |> cast(attrs, [:x_cordinate, :y_cordinate, :face])
    |> validate_required([:x_cordinate, :y_cordinate, :face])
  end
end
