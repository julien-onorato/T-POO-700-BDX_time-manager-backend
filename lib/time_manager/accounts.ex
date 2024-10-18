defmodule TimeManager.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  import Ecto.Changeset

  alias TimeManager.Repo
  alias TimeManager.Accounts.User
  alias TimeManager.WorkingTimes.WorkingTime


  def list_all_workingtimes do
    Repo.all(WorkingTime)
    |> Repo.preload(:user)  # Préchargez les informations de l'utilisateur associé
  end

  @doc """
  Returns the list of users.

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> put_pass_hash()
    |> Repo.insert()
  end

  @doc """
  Hash password.

  """
  defp put_pass_hash(changeset) do
    case get_change(changeset, :password) do
      nil -> changeset
      password -> put_change(changeset, :password_hash, Bcrypt.hash_pwd_salt(password))
    end
  end

  @doc """
  Updates a user.

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  @doc """
  Gets a single userby email and username

  Raises `Ecto.NoResultsError` if the User does not exist.
  """
  def get_users_by_filter(email, username) do
    User
    |> where([u], u.email == ^email or u.username == ^username)
    |> Repo.all()
  end

  # Fonction pour récupérer un utilisateur par email
  def get_user_by_email(email) do
    Repo.get_by(User, email: email)
    |> case do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end
end
