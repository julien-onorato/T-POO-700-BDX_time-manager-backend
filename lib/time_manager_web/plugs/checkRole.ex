defmodule TimeManagerWeb.Plugs.CheckRole do
  import Plug.Conn
  import Phoenix.Controller
  alias TimeManager.Accounts

  def init(default), do: default

  # On vérifie que l'utilisateur a au moins un certain rôle
  def call(conn, required_role) do
    current_user = get_current_user(conn)  # Récupérez l'utilisateur authentifié depuis le JWT

    if role_hierarchy(current_user.role) >= role_hierarchy(required_role) do
      conn
    else
      conn
      |> put_status(:forbidden)
      |> json(%{error: "You do not have the required permissions to access this resource."})
      |> halt()
    end
  end

  # Cette fonction attribue un niveau à chaque rôle pour établir une hiérarchie
  defp get_current_user(conn) do
    # Assuming you have a function to extract the user from the JWT token in the connection
    # This is a placeholder implementation
    %{role: "Employee"}  # Replace with actual user extraction logic
  end

  defp role_hierarchy("Admin"), do: 4
  defp role_hierarchy("Super Manager"), do: 3
  defp role_hierarchy("Manager"), do: 2
  defp role_hierarchy("Employee"), do: 1
  defp role_hierarchy(_), do: 0
end
