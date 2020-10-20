defmodule AppTest.Repo do
  use Ecto.Repo,
    otp_app: :app_test,
    adapter: Ecto.Adapters.Postgres
end
