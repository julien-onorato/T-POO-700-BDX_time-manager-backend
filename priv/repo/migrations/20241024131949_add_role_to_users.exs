defmodule TimeManager.Repo.Migrations.AddRoleToUsers do
  use Ecto.Migration

  def change do
    # Vérifie si la colonne existe avant de l'ajouter
    execute("""
    DO $$
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM information_schema.columns
                       WHERE table_name='users' AND column_name='role') THEN
            ALTER TABLE users ADD COLUMN role VARCHAR;
        END IF;
    END $$;
    """)
  end
end
