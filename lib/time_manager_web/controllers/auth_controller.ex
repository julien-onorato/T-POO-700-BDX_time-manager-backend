defmodule TimeManagerWeb.AuthController do
  use TimeManagerWeb, :controller

  alias TimeManager.Accounts
  alias TimeManager.Auth

  def register(conn, %{"email" => email, "password" => password, "username" => username}) do
    case Accounts.create_user(%{email: email, password: password, username: username}) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> json(%{user_id: user.id})

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{error: changeset.errors})
    end
  end


  def login(conn, %{"email" => email, "password" => password}) do
    case Accounts.get_user_by_email(email) do
      {:ok, user} ->
        if Auth.check_password(user, password) do
          case Auth.generate_jwt(user) do
            {:ok, jwt} ->
              conn
              |> put_resp_cookie("token", jwt, http_only: true) # Stocker le token dans un cookie
              |> put_status(:ok)
              |> json(%{user_id: user.id}) # Ne pas renvoyer le token dans la réponse JSON

            {:error, reason} ->
              conn
              |> put_status(:internal_server_error)
              |> json(%{error: "Failed to generate token", details: reason})
          end
        else
          conn
          |> put_status(:unauthorized)
          |> json(%{error: "Invalid credentials"})
        end

      {:error, _} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "Invalid credentials"})
    end
  end
end
