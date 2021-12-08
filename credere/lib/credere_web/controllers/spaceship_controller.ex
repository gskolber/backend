defmodule CredereWeb.SpaceshipController do
  use CredereWeb, :controller

  alias Credere.Space
  alias Credere.Space.Spaceship
  # To generate unique ids for the spaceships.
  import UUID

  def start(conn, _params) do
    with uuid <- uuid4(),
         {:ok, spaceship} <- Space.create_spaceship(%Spaceship{}, uuid) do
      conn
      |> json(spaceship)
    end
  end

  def status(conn, %{"game_session" => game_session}) do
    with spaceship <- Space.get_spaceship(game_session),
     false <- is_nil(spaceship) do
      conn
      |> json(spaceship)
    else
      true ->
        conn
        |> put_status(404)
        |> json(%{:error => "Spaceship not found"})
    end
  end

  def move(conn, %{"movimentos" => movements, "game_session" => game_session}) do
    initial_spaceship = Space.get_spaceship(game_session)

    with nil <- Space.make_move(initial_spaceship, movements),
         new_location = Space.get_spaceship(game_session) do
      conn
      |> json(%{
        "x" => new_location.x_cordinate,
        "y" => new_location.y_cordinate,
        "face" => new_location.face
      })
    else
      _ ->
        Space.reset_spaceship(initial_spaceship, %{
          x_cordinate: initial_spaceship.x_cordinate,
          y_cordinate: initial_spaceship.y_cordinate,
          face: initial_spaceship.face
        })

        conn
        |> json(%{
          "error" => "Não foi possível mover o espaçonave"
        })
    end
  end
end
