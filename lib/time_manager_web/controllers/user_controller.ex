defmodule TimeManagerWeb.UserController do
  use TimeManagerWeb, :controller

  defp get_current_user(conn) do
    conn.assigns[:current_user]
  end

  alias TimeManager.Accounts
  alias TimeManager.Accounts.User
  alias TimeManager.Repo

  plug TimeManagerWeb.Plugs.CheckRole, "Admin" when action in [:promote, :demote]
  plug TimeManagerWeb.Plugs.CheckRole, "Super Manager" when action in [:manage_managers]
  plug TimeManagerWeb.Plugs.CheckRole, "Manager" when action in [:manage_employees]

  # GET /api/users (optionnellement filtrer par username et email)
  def index(conn, %{"username" => username, "email" => email}) do
    users = Accounts.get_users_by_filter(email, username)
    render(conn, "index.json", users: users)
  end

  def index(conn, params) do
    users = case {params["email"], params["username"]} do
      {email, username} when is_binary(email) and is_binary(username) ->
        Accounts.get_users_by_filter(email, username)
      _ ->
        Accounts.list_users()
    end
    render(conn, "index.json", users: users)
  end

  # GET /api/current_user
  def current_user(conn, _params) do
    claims = conn.assigns[:current_user]

    # Assurez-vous que claims n'est pas nil avant de continuer
    if claims do
      user_id = claims["user_id"]

      case Accounts.get_user!(user_id) do
        user ->
          render(conn, "show.json", user: user)

        # Cela ne devrait jamais se produire si get_user! fonctionne correctement,
        # mais vous pouvez gérer une exception ici si vous le souhaitez.
        _ ->
          conn
          |> put_status(:not_found)
          |> json(%{error: "User not found"})
      end
    else
      conn
      |> put_status(:unauthorized)
      |> json(%{error: "Unauthorized"})
    end
  end

  # DELETE /api/logout
  def logout(conn, _params) do
    # Supprimer le cookie `token`
    conn
    |> put_resp_cookie("token", "", max_age: 0)  # Définir max_age à 0 pour supprimer le cookie
    |> json(%{message: "Successfully logged out"})
  end


  # GET /api/users/:id
  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user)
  end

  # POST /api/users
  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> json(%{
          status: "success",
          message: "User created successfully.",
          user: user
        })

      {:error, changeset} ->
        errors = Enum.map(changeset.errors, fn {field, {message, _}} ->
          "#{field} #{message}"
        end)

        conn
        |> put_status(:unprocessable_entity)
        |> json(%{
          status: "error",
          message: "Failed to create user.",
          errors: errors
        })
    end
  end

  # PUT /api/users/:id
  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    case Accounts.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> json(%{
          status: "success",
          message: "User updated successfully.",
          user: user
        })

      {:error, changeset} ->
        errors = Enum.map(changeset.errors, fn {field, {message, _}} ->
          "#{field} #{message}"
        end)

        conn
        |> put_status(:unprocessable_entity)
        |> json(%{
          status: "error",
          message: "Failed to update user.",
          errors: errors
        })
    end
  end

  # DELETE /api/users/:id
  def delete(conn, %{"id" => id}) do
    case Repo.get(User, id) do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{
          status: "error",
          message: "User not found."
        })

      user ->
        case Accounts.delete_user(user) do
          {:ok, _user} ->
            conn
            |> put_status(:ok)
            |> json(%{
              status: "success",
              message: "User deleted successfully."
            })

          {:error, changeset} ->
            errors = Enum.map(changeset.errors, fn {field, {message, _}} ->
              "#{field} #{message}"
            end)

            conn
            |> put_status(:unprocessable_entity)
            |> json(%{
              status: "error",
              message: "Failed to delete user.",
              errors: errors
            })
        end
    end
  end

  # def promote(conn, %{"id" => id, "role" => role}) do
  #   valid_roles = ["Admin", "Manager", "User"] # Liste des rôles valides

  #   if role in valid_roles do
  #     with user <- Accounts.get_user!(id) do
  #       changeset = user
  #       |> Ecto.Changeset.change()
  #       |> Ecto.Changeset.put_change(:role, role)

  #       case Repo.update(changeset) do
  #         {:ok, _updated_user} ->
  #           conn
  #           |> put_status(:ok)
  #           |> json(%{message: "User promoted successfully"})

  #         {:error, changeset} ->
  #           conn
  #           |> put_status(:unprocessable_entity)
  #           |> json(%{errors: changeset.errors})
  #       end
  #     else
  #       _ ->
  #         conn
  #         |> put_status(:not_found)
  #         |> json(%{error: "User not found"})
  #     end
  #   else
  #     conn
  #     |> put_status(:bad_request)
  #     |> json(%{error: "Invalid role"})
  #   end
  # end

  def promote(conn, %{"id" => id, "role" => role}) do
    current_user = get_current_user(conn)

    # Vérifiez que l'utilisateur a les permissions pour promouvoir
    if current_user.role == "Admin" do
      if role == "Admin" and Accounts.admin_exists?() do
        conn
        |> put_status(:bad_request)
        |> json(%{error: "There is already an admin. Only one admin is allowed."})
      else
        # Logique de promotion
      end
    else
      conn
      |> put_status(:forbidden)
      |> json(%{error: "You do not have permission to promote users."})
    end
  end



  def demote(conn, %{"id" => id}) do
    promoter = conn.assigns.current_user
    target = Accounts.get_user!(id)

    case Accounts.demote_user(promoter, target) do
      {:ok, _user} ->
        conn
        |> put_status(:ok)
        |> json(%{message: "User demoted successfully"})
      {:error, reason} ->
        conn
        |> put_status(:forbidden)
        |> json(%{error: reason})
    end
  end
end
