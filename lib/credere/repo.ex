defmodule Credere.Repo do
  use Ecto.Repo,
    otp_app: :credere,
    adapter: Ecto.Adapters.Postgres
end
