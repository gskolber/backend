defmodule Credere.Space do
  @moduledoc """
  The Space context.
  """

  import Ecto.Query, warn: false
  alias Credere.Repo

  alias Credere.Space.Spaceship

  @doc """
  Gets a single spaceship.

  Returns nil if no spaceship is found.

  ## Examples

      iex> get_spaceship("my_space_ship_game_session")
      %Spaceship{}

      iex> get_spaceship("no_existant_game_session))
      nil

  """
  def get_spaceship(game_session) do
    spaceship = Repo.get_by(Spaceship, %{game_session: game_session})

    if not is_nil(spaceship) do
      {:ok, spaceship}
    else
      {:error, nil}
    end
  end

  @doc """
  Get a spaceship and sanitize his last move field.
  """
  def get_valid_spaceship(game_session) do
    with {:ok, spaceship} <- get_spaceship(game_session) do
      spaceship
      |> Spaceship.reset_spaceship_changeset()
      |> update_spaceship()
    else
      {:error, nil} ->
        {:error, nil}
    end
  end

  @doc """
  Creates a spaceship and start his adventure!!.

  ## Examples

      iex> create_spaceship()
      {:ok, %Spaceship{}}

  """
  def create_spaceship(spaceship \\ %Spaceship{}, uuid) do
    spaceship
    |> Spaceship.changeset(%{game_session: uuid})
    |> Repo.insert()
  end

  @doc """
  Updates a spaceship.
  Receives a spaceship and a list of movements
  If all movements are valid, the spaceship is updated.
  If not all movements are valid, the spaceship is not updated and return to the initial state
  """

  def make_move(spaceship, movements) do
    valid_movements? =
      Enum.find(
        movements,
        fn movement ->
          {:ok, spaceship_now} = get_spaceship(spaceship.game_session)

          spaceship_after =
            next_movement(spaceship_now, movement, possible_movements(spaceship_now.face))

          case spaceship_after.valid? do
            true ->
              spaceship_after
              |> Repo.update()

              false

            false ->
              true
          end
        end
      )

    if is_nil(valid_movements?) do
      {:valid}
    else
      {:illegal}
    end
  end

  defp possible_movements(actual_movement) do
    case actual_movement do
      "direita" -> ["baixo", "cima"]
      "baixo" -> ["esquerda", "direita"]
      "esquerda" -> ["cima", "baixo"]
      "cima" -> ["direita", "esquerda"]
    end
  end

  @doc """

  Receives a spaceship and updates him
  """

  def update_spaceship(spaceship) do
    spaceship
    |> Repo.update()
  end

  @doc """

  Receives a spaceship and turn him to your initial value

  """

  def reset_spaceship(spaceship, attrs) do
    Repo.get(Spaceship, spaceship.id)
    |> Spaceship.reset_spaceship_changeset(attrs)
    |> Repo.update()
  end

  defp next_movement(spaceship, move, _possible_movements) when move == "M" do
    spaceship
    |> Spaceship.new_cordinates_changeset()
  end

  defp next_movement(spaceship, move, possible_movements) when move == "GD" do
    spaceship
    |> Spaceship.new_face_changeset(%{
      face: Enum.at(possible_movements, 0),
      last_move: spaceship.last_move
    })
  end

  defp next_movement(spaceship, move, possible_movements) when move == "GE" do
    spaceship
    |> Spaceship.new_face_changeset(%{
      face: Enum.at(possible_movements, 1, last_move: spaceship.last_move)
    })
  end
end
