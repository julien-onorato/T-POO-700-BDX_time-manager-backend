defmodule TimeManagerWeb.UserController do
  use TimeManagerWeb, :controller

  alias TimeManager.Accounts
  alias TimeManager.Accounts.User
  alias TimeManager.Repo

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
end
