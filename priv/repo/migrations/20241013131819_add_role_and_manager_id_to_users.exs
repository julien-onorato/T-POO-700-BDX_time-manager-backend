defmodule TimeManager.Repo.Migrations.AddRoleAndManagerIdToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :role, :string, default: "Employee", null: false
      add :manager_id, references(:users, on_delete: :nothing)
    end
  end
end
