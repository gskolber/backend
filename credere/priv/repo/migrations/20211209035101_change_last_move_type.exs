defmodule Credere.Repo.Migrations.ChangeLastMoveType do
  use Ecto.Migration

  def change do
    alter table(:spaceships) do
      modify :last_move, :text
    end
  end
end
