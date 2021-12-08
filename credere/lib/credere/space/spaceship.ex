defmodule Credere.Space.Spaceship do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:face, :x_cordinate, :y_cordinate, :game_session]}
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

  def new_cordinates_changeset(spaceship, attrs \\ %{}) do
    spaceship
    |> cast(attrs, [:x_cordinate, :y_cordinate, :face])
    |> add_next_cordinate()
    |> validate_number(:x_cordinate, less_than: 5, greater_than: -1)
    |> validate_number(:y_cordinate, less_than: 5, greater_than: -1)
  end

  def new_face_changeset(spaceship, attrs \\ %{}) do
    spaceship
    |> cast(attrs, [:face])
  end

  def reset_spaceship_changeset(spaceship, attrs \\ %{}) do
    spaceship
    |> cast(attrs, [:x_cordinate, :y_cordinate, :face])
  end

  defp add_next_cordinate(changeset) do
    case changeset.data.face do
      "right" -> changeset |> put_change(:x_cordinate, changeset.data.x_cordinate + 1)
      "left" -> changeset |> put_change(:x_cordinate, changeset.data.x_cordinate - 1)
      "top" -> changeset |> put_change(:y_cordinate, changeset.data.y_cordinate + 1)
      "bottom" -> changeset |> put_change(:y_cordinate, changeset.data.y_cordinate - 1)
    end
  end
end
