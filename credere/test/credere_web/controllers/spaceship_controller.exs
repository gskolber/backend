defmodule CredereWeb.SpaceshipControllerTest do
  use CredereWeb.ConnCase

  describe "start" do
    test "should start the spaceship",  %{conn: conn} do
      conn = post(conn, "/api/spaceship/create")

      %{"x_cordinate"=> x_cordinate, "y_cordinate"=> y_cordinate, "face"=> face} = json_response(conn, 200)

      assert x_cordinate == 0
      assert y_cordinate == 0
      assert face == "right"
    end
  end

  describe "status" do
    test "should return the spaceship status",  %{conn: conn} do
      start = post(conn, "/api/spaceship/create")
      %{"game_session"=> start_game_session} = json_response(start, 200)
      conn = get(conn, "/api/spaceship/" <> start_game_session)

      %{"x_cordinate"=> x_cordinate, "y_cordinate"=> y_cordinate, "face"=> face, "game_session"=> game_session} = json_response(conn, 200)

      assert x_cordinate == 0
      assert y_cordinate == 0
      assert face == "right"
      assert game_session == start_game_session
    end
  end

  describe "move" do
    test "should move the spaceship",  %{conn: conn} do
      start = post(conn, "/api/spaceship/create")
      %{"game_session"=> start_game_session} = json_response(start, 200)
      conn = patch(conn, "/api/spaceship/" <> start_game_session, movimentos: ["GE", "M", "M", "M", "GD", "M", "M"])

      %{"x"=> x_cordinate, "y"=> y_cordinate, "face"=> face} = json_response(conn, 200)

      assert x_cordinate == 2
      assert y_cordinate == 3
      assert face == "right"
    end
  end

end
