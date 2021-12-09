defmodule Credere.Space.Spaceship do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:face, :x_cordinate, :y_cordinate, :game_session, :last_move]}
  schema "spaceships" do
    field :face, :string, default: "direita", required: true
    field :x_cordinate, :integer, default: 0, required: true
    field :y_cordinate, :integer, default: 0, required: true
    field :game_session, :string
    field :last_move, :string, default: "Você começou a navegar e: "

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
    |> validate_number(:x_cordinate, less_than: 5, greater_than: 0)
    |> validate_number(:y_cordinate, less_than: 5, greater_than: 0)
    |> add_description_movement()
  end

  def new_face_changeset(spaceship, attrs \\ %{}) do
    spaceship
    |> cast(attrs, [:face, :last_move])
    |> add_description_face()
  end

  def reset_spaceship_changeset(spaceship, attrs \\ %{}) do
    spaceship
    |> cast(attrs, [:x_cordinate, :y_cordinate, :face, :last_move])
    |> put_change(:last_move, "")
  end

  defp add_next_cordinate(changeset) do
    case changeset.data.face do
      "direita" -> changeset |> put_change(:x_cordinate, changeset.data.x_cordinate + 1)
      "esquerda" -> changeset |> put_change(:x_cordinate, changeset.data.x_cordinate - 1)
      "cima" -> changeset |> put_change(:y_cordinate, changeset.data.y_cordinate + 1)
      "baixo" -> changeset |> put_change(:y_cordinate, changeset.data.y_cordinate - 1)
    end
  end

  defp add_description_movement(changeset) when not is_nil(changeset.changes.x_cordinate) do
    changeset
    |> put_change(
      :last_move,
      changeset.data.last_move <>
        "Você se moveu para #{changeset.changes.x_cordinate}, #{changeset.data.y_cordinate},"
    )
  end

  defp add_description_movement(changeset) when not is_nil(changeset.changes.y_cordinate) do
    changeset
    |> put_change(
      :last_move,
      changeset.data.last_move <>
        "Você se moveu para #{changeset.data.x_cordinate}, #{changeset.changes.y_cordinate},"
    )
  end

  defp add_description_face(changeset) do
    changeset
    |> put_change(
      :last_move,
      changeset.data.last_move <> "Você se virou para #{changeset.changes.face},"
    )
  end
end
