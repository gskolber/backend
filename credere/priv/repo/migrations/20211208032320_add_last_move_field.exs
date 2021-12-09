defmodule Credere.Repo.Migrations.AddLastMoveField do
  use Ecto.Migration

  def change do
    alter table(:spaceships) do
      add :last_move, :string
    end
  end
end
