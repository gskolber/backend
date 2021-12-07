defmodule Credere.Repo.Migrations.CreateSpaceships do
  use Ecto.Migration

  def change do
    create table(:spaceships) do
      add :x_cordinate, :integer
      add :y_cordinate, :integer
      add :face, :string
      add :game_session, :string

      timestamps()
    end
  end
end
