defmodule TimeManagerWeb.Plugs.AuthenticateJWT do
  import Plug.Conn
  import Phoenix.Controller, only: [json: 2]

  alias TimeManager.Auth

  # Initialisation du plug (nécessaire pour les plugs)
  def init(default), do: default

  # Fonction d'appel du plug qui va vérifier le JWT
  def call(conn, _opts) do
    case get_jwt(conn) do
      {:ok, jwt} ->
        case Auth.verify_jwt(jwt) do
          {:ok, claims} ->
            IO.inspect(claims, label: "JWT Claims")  # Inspecter les claims
            assign(conn, :current_user, %{"user_id" => claims["user_id"]})
          {:error, _reason} ->
            conn
            |> put_status(:unauthorized)
            |> json(%{error: "Invalid or expired token"})
            |> halt()
        end

      :error ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "Token not found"})
        |> halt()
    end
  end

  # Fonction pour extraire le token JWT des cookies de requête
  defp get_jwt(conn) do
    case Map.get(conn.req_cookies, "token") do
      nil -> :error
      token -> {:ok, token}
    end
  end
end
