defmodule TimeManager.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @roles ["Manager", "GeneralManager", "Employee"]

  schema "users" do
    field :username, :string
    field :email, :string
    field :role, :string, default: "Employee"

    belongs_to :manager, TimeManager.Accounts.User, foreign_key: :manager_id
    has_many :workingtimes, TimeManager.WorkingTimes.WorkingTime

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :role, :manager_id])
    |> validate_required([:username, :email, :role])
    |> validate_format(:email, ~r/^[\w._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/, message: "must be in the format X@X.X")
    |> validate_inclusion(:role, @roles, message: "must be one of: #{@roles}")
    |> unique_constraint(:email)
    |> unique_constraint(:username)
  end
end

defimpl Jason.Encoder, for: TimeManager.Accounts.User do
  def encode(%TimeManager.Accounts.User{username: username, email: email, id: id, role: role, manager_id: manager_id}, opts) do
    Jason.Encode.map(%{
      id: id,
      username: username,
      email: email,
      role: role,
      manager_id: manager_id
    }, opts)
  end
end
