defmodule TimeManagerWeb.UserControllerTest do
  use TimeManagerWeb.ConnCase

  alias TimeManager.Accounts
  alias TimeManager.Repo

  setup do
    # Créez des utilisateurs pour les tests avec différents rôles
    admin = Accounts.create_user(%{email: "admin@example.com", username: "admin", role: "Admin"})
    super_manager = Accounts.create_user(%{email: "super_manager@example.com", username: "supermanager", role: "Super Manager"})
    manager = Accounts.create_user(%{email: "manager@example.com", username: "manager", role: "Manager"})
    employee = Accounts.create_user(%{email: "employee@example.com", username: "employee", role: "Employee"})

    {:ok, admin: admin, super_manager: super_manager, manager: manager, employee: employee}
  end

  test "Admin can promote a user", %{conn: conn, admin: admin, manager: manager} do
    conn = assign(conn, :current_user, admin)
    conn = put(conn, Routes.user_path(conn, :promote, manager.id), %{"role" => "Super Manager"})

    assert json_response(conn, 200)["message"] == "User promoted successfully"
    assert Repo.get!(Accounts.User, manager.id).role == "Super Manager"
  end

  test "Employee cannot promote a user", %{conn: conn, employee: employee, manager: manager} do
    conn = assign(conn, :current_user, employee)
    conn = put(conn, Routes.user_path(conn, :promote, manager.id), %{"role" => "Super Manager"})

    assert json_response(conn, 403)["error"] == "You do not have permission to promote users. Please contact an admin if you believe this is an error."
  end

  test "Admin cannot promote to Admin if one already exists", %{conn: conn, admin: admin, super_manager: super_manager} do
    conn = assign(conn, :current_user, admin)
    conn = put(conn, Routes.user_path(conn, :promote, super_manager.id), %{"role" => "Admin"})

    assert json_response(conn, 400)["error"] == "There is already an admin. Only one admin is allowed."
  end

  test "Super Manager can promote Manager but not Admin", %{conn: conn, super_manager: super_manager, manager: manager} do
    conn = assign(conn, :current_user, super_manager)

    # Promotion valide à Manager
    conn = put(conn, Routes.user_path(conn, :promote, manager.id), %{"role" => "Manager"})
    assert json_response(conn, 200)["message"] == "User promoted successfully"

    # Tentative de promotion à Admin
    conn = put(conn, Routes.user_path(conn, :promote, manager.id), %{"role" => "Admin"})
    assert json_response(conn, 403)["error"] == "You do not have permission to promote users."
  end
end
