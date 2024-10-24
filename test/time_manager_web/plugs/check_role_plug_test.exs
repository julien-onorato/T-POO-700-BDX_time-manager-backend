defmodule TimeManagerWeb.Plugs.CheckRoleTest do
  use TimeManagerWeb.ConnCase

  alias TimeManagerWeb.Plugs.CheckRole
  alias TimeManager.Accounts

  setup do
    admin = Accounts.create_user(%{email: "admin@example.com", username: "admin", role: "Admin"})
    manager = Accounts.create_user(%{email: "manager@example.com", username: "manager", role: "Manager"})
    employee = Accounts.create_user(%{email: "employee@example.com", username: "employee", role: "Employee"})

    {:ok, admin: admin, manager: manager, employee: employee}
  end

  test "Admin can access a route that requires Admin role", %{conn: conn, admin: admin} do
    conn = assign(conn, :current_user, admin)
    conn = CheckRole.call(conn, "Admin")

    # Si l'accès est autorisé, le statut est 200 (OK)
    refute conn.halted
  end

  test "Employee cannot access a route that requires Admin role", %{conn: conn, employee: employee} do
    conn = assign(conn, :current_user, employee)
    conn = CheckRole.call(conn, "Admin")

    # Si l'accès est interdit, l'appel est stoppé et le statut est 403 (Forbidden)
    assert conn.halted
    assert json_response(conn, 403)["error"] == "You do not have the required permissions to access this resource."
  end

  test "Super Manager can access a route that requires Manager role", %{conn: conn, super_manager: super_manager} do
    conn = assign(conn, :current_user, super_manager)
    conn = CheckRole.call(conn, "Manager")

    # Le Super Manager peut accéder aux routes des Managers
    refute conn.halted
  end

  test "Manager cannot access a route that requires Super Manager role", %{conn: conn, manager: manager} do
    conn = assign(conn, :current_user, manager)
    conn = CheckRole.call(conn, "Super Manager")

    # Le Manager ne peut pas accéder aux routes réservées aux Super Managers
    assert conn.halted
    assert json_response(conn, 403)["error"] == "You do not have the required permissions to access this resource."
  end
end
