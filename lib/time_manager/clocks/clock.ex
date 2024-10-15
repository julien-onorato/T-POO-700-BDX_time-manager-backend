defmodule TimeManager.Clocks.Clock do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clocks" do
    field :status, :boolean
    field :time, :utc_datetime
    field :user_id, :integer
    timestamps()
  end

  def changeset(clock, attrs) do
    clock
    |> cast(attrs, [:status, :time, :user_id])
    |> validate_required([:status, :time, :user_id])
  end
end
