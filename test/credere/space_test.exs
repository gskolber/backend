defmodule Credere.SpaceTest do
  use Credere.DataCase

  alias Credere.Space

  describe "spaceships" do
    alias Credere.Space.Spaceship

    import Credere.SpaceFixtures

    test "get_spaceship/1 returns the spaceship with given game_session" do
      spaceship = spaceship_fixture()
      {:ok, find_spaceship} = Space.get_spaceship(spaceship.game_session)
      assert find_spaceship == spaceship
    end

    test "create_spaceship/1 with valid data creates a spaceship" do
      uuid = UUID.uuid4()
      valid_attrs = %{face: "direita", x_cordinate: 0, y_cordinate: 0}

      assert {:ok, %Spaceship{} = spaceship} = Space.create_spaceship(%Spaceship{}, uuid)
      assert spaceship.face == valid_attrs.face
      assert spaceship.game_session == uuid
      assert spaceship.x_cordinate == valid_attrs.x_cordinate
      assert spaceship.y_cordinate == valid_attrs.y_cordinate
    end

    test "update_spaceship/2 with valid data updates the spaceship" do
      update_attrs = %{face: "left", x_cordinate: 1, y_cordinate: 1}

      spaceship =
        spaceship_fixture()
        |> Spaceship.new_cordinates_changeset(update_attrs)

      assert {:ok, %Spaceship{} = spaceship} = Space.update_spaceship(spaceship)
      assert spaceship.face == "left"
      assert spaceship.x_cordinate == 1
      assert spaceship.y_cordinate == 1
    end
  end
end
