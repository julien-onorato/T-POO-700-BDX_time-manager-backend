defmodule TimeManager.WorkingTimes.WorkingTime do
  use Ecto.Schema
  import Ecto.Changeset

  schema "workingtime" do
    field :start, :utc_datetime
    field :end, :utc_datetime
    # field :user_id, :id
    belongs_to :user, TimeManager.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(working_time, attrs) do
    working_time
    |> cast(attrs, [:start, :end, :user_id])
    |> validate_required([:start, :end, :user_id])
    |> validate_end_after_start() # Ajout de la validation personnalisée
    |> foreign_key_constraint(:user_id)
  end

  # Validation personnalisée pour s'assurer que `end` est après `start`
  defp validate_end_after_start(changeset) do
    start_time = get_field(changeset, :start)
    end_time = get_field(changeset, :end)

    cond do
      start_time && end_time && DateTime.compare(start_time, end_time) == :gte ->
        add_error(changeset, :end, "must be after start time")
      true ->
        changeset
    end
  end
end

defimpl Jason.Encoder, for: TimeManager.WorkingTimes.WorkingTime do
  def encode(%{id: id, start: start, end: end_time, user_id: user_id}, opts) do
    map = %{
      id: id,
      start: DateTime.to_iso8601(start),
      end: DateTime.to_iso8601(end_time),  # Utilisation de end_time ici
      user_id: user_id
    }

    Jason.Encode.map(map, opts)
  end
end
