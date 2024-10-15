defmodule TimeManager.Clocks.ClockPeriod do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :clock_in, :clock_out, :user_id, :inserted_at, :updated_at]}
  schema "clock_periods" do
    field :clock_in, :utc_datetime
    field :clock_out, :utc_datetime
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(clock_period, attrs) do
    clock_period
    |> cast(attrs, [:clock_in, :clock_out, :user_id])
    |> validate_required([:clock_in, :user_id])
  end
end
