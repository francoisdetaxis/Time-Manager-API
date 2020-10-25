defmodule AppTest.Repo.Migrations.CreateWorkingtimes do
  use Ecto.Migration

  def change do
    create table(:workingtimes) do
      add :start, :naive_datetime, null: false
      add :end, :naive_datetime, null: false
      add :users_id, references(:users, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:workingtimes, [:users_id])
  end
end
