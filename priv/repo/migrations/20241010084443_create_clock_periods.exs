defmodule TimeManager.Repo.Migrations.CreateClockPeriods do
  use Ecto.Migration

  def change do
    create table(:clock_periods) do
      add :clock_in, :utc_datetime
      add :clock_out, :utc_datetime
      add :user_id, :integer, null: false

      timestamps()
    end

    create index(:clock_periods, [:user_id])
  end
end
