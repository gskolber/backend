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
  def get_spaceship(game_session), do: Repo.get_by(Spaceship, %{game_session: game_session})

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

  ## Examples

      iex> update_spaceship(spaceship, %{field: new_value})
      {:ok, %Spaceship{}}

      iex> update_spaceship(spaceship, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_spaceship(%Spaceship{} = spaceship, attrs) do
    spaceship
    |> Spaceship.new_cordinates_changeset(attrs)
    |> Repo.update()
  end
end
