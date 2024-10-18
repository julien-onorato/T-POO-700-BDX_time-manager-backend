defmodule TimeManager.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bcrypt

  @roles ["Manager", "GeneralManager", "Employee"]

  @derive {Jason.Encoder, only: [:id, :username, :email, :role]}
  schema "users" do
    field :username, :string
    field :email, :string
    field :role, :string, default: "Employee"
    field :password_hash, :string
    field :password, :string, virtual: true

    belongs_to :manager, TimeManager.Accounts.User, foreign_key: :manager_id
    has_many :workingtimes, TimeManager.WorkingTimes.WorkingTime

    timestamps(type: :utc_datetime)
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :role, :password])
    |> validate_required([:username, :email, :role, :password])
    |> validate_inclusion(:role, @roles)
    |> validate_length(:password, min: 6)
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
    case get_change(changeset, :password) do
      nil -> changeset
      password -> put_change(changeset, :password_hash, Bcrypt.hash_pwd_salt(password))
    end
  end
end
