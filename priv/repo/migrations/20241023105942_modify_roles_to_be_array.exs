defmodule TimeManager.Repo.Migrations.ModifyRolesToBeArray do
  use Ecto.Migration

  def up do
    # Étape 1: Renommer la colonne 'roles'
    rename table(:users), :roles, to: :roles_temp

    # Étape 2: Ajouter une nouvelle colonne 'roles' de type array
    alter table(:users) do
      add :roles, {:array, :string}, default: []
    end

    # Étape 3: Migrer les données de 'roles_temp' vers 'roles'
    execute "UPDATE users SET roles = ARRAY[roles_temp] WHERE roles_temp IS NOT NULL;"

    # Étape 4: Supprimer l'ancienne colonne 'roles_temp'
    alter table(:users) do
      remove :roles_temp
    end
  end

  def down do
    # Étape 4: Ajouter la colonne 'roles_temp'
    alter table(:users) do
      add :roles_temp, :string
    end

    # Étape 3: Migrer les données de 'roles' vers 'roles_temp'
    execute "UPDATE users SET roles_temp = roles[1] WHERE roles IS NOT NULL AND array_length(roles, 1) > 0;"

    # Étape 2: Supprimer la colonne 'roles'
    alter table(:users) do
      remove :roles
    end

    # Étape 1: Renommer la colonne 'roles_temp' en 'roles'
    rename table(:users), :roles_temp, to: :roles
  end
end
