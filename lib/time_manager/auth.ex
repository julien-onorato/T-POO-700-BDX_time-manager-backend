defmodule TimeManager.Auth do
  use Joken.Config

  alias TimeManager.Accounts
  alias TimeManager.Accounts.User
  alias Bcrypt

  # Chargement de la clé secrète
  @secret System.get_env("JWT_SECRET_KEY")

  def authenticate_user(email, password) do
    with {:ok, user} <- Accounts.get_user_by_email(email),
         true <- check_password(user, password) do
      case generate_jwt(user) do
        {:ok, jwt, claims} -> {:ok, jwt, claims}
        {:error, reason} -> {:error, reason}
      end
    else
      _ -> {:error, :invalid_credentials}
    end
  end

  def get_user_by_email(email) do
    Repo.get_by(User, email: email)
    |> case do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end

  # Rendre cette fonction publique (def au lieu de defp)
  def check_password(nil, _password), do: false

  def check_password(user, password) do
    IO.inspect(user.password_hash, label: "Password Hash")
    IO.inspect(password, label: "Input Password")

    Bcrypt.check_pass(user, password)
  end

  def generate_jwt(%User{id: user_id, email: email, username: username, role: role}) do
    binary_key = get_binary_secret(@secret)  # Conversion en binaire
    signer = Joken.Signer.create("HS256", binary_key)
    claims = %{
      "user_id" => user_id,
      "email" => email,
      "username" => username,
      "role" => role
    }

    case Joken.encode_and_sign(claims, signer) do
      {:ok, token, _claims} -> {:ok, token}  # On renvoie juste le token
      {:error, reason} -> {:error, reason}
    end
  end


  def verify_jwt(token) do
    # Utilisation de votre clé secrète directement pour créer le signer
    binary_key = get_binary_secret(@secret)  # Conversion en binaire
    signer = Joken.Signer.create("HS256", binary_key)

    IO.inspect(token, label: "Token")
    IO.inspect(signer, label: "Signer")

    # Utilisation de Joken.Signer.verify/2
    case Joken.Signer.verify(token, signer) do
      {:ok, claims} -> {:ok, claims}  # Si tout est bon, on retourne les claims
      {:error, reason} -> {:error, reason}  # En cas d'erreur, on retourne la raison
    end
  end

  defp get_binary_secret(secret) do
    binary_secret = :binary.copy(secret)
  end
end
