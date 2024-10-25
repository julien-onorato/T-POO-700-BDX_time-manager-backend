defmodule TimeManager.Accounts.Roles do
  def can_promote?(promoter_role, target_role) do
    roles_hierarchy = %{
      "admin" => ["super manager", "manager", "employee"],
      "super manager" => ["manager", "employee"],
      "manager" => ["employee"],
      "employee" => []
    }

    Enum.member?(roles_hierarchy[promoter_role], target_role)
  end

  def can_demote?(promoter_role, target_role) do
    roles_hierarchy = %{
      "admin" => ["super manager", "manager", "employee"],
      "super manager" => ["manager", "employee"],
      "manager" => ["employee"],
      "employee" => []
    }

    Enum.member?(roles_hierarchy[promoter_role], target_role)
  end
end
