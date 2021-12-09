defmodule Credere.SpaceFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Credere.Space` context.
  """

  # for uuid4
  import UUID

  @doc """
  Generate a spaceship.
  """
  def spaceship_fixture() do
    uuid = uuid4()

    {:ok, spaceship} = Credere.Space.create_spaceship(uuid)

    spaceship
  end
end
