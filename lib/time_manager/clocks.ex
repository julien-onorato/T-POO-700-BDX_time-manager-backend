defmodule TimeManager.Clocks do
  @moduledoc """
  The Clocks context.
  """

  import Ecto.Query, warn: false
  alias TimeManager.Repo

  alias TimeManager.Clocks.Clock
  alias TimeManager.Clocks.ClockPeriod

  @doc """
  Returns the list of clocks.

  ## Examples

      iex> list_clocks()
      [%Clock{}, ...]
  """
  def list_clocks do
    Repo.all(Clock)
  end

  @doc """
  Gets a single clock.

  Raises `Ecto.NoResultsError` if the Clock does not exist.

  ## Examples

      iex> get_clock!(123)
      %Clock{}

      iex> get_clock!(456)
      ** (Ecto.NoResultsError)
  """
  def get_clock!(id), do: Repo.get!(Clock, id)

  @doc """
  Creates a clock with clock_in and clock_out.

  ## Examples

      iex> create_clock(%{clock_in: ~U[2024-10-10 09:00:00Z], clock_out: ~U[2024-10-10 17:00:00Z], user_id: 1})
      {:ok, %Clock{}}

      iex> create_clock(%{clock_in: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def create_clock(attrs \\ %{}) do
    %Clock{}
    |> Clock.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a clock.

  ## Examples

      iex> update_clock(clock, %{clock_out: ~U[2024-10-10 17:30:00Z]})
      {:ok, %Clock{}}

      iex> update_clock(clock, %{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def update_clock(%Clock{} = clock, attrs) do
    clock
    |> Clock.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a clock.

  ## Examples

      iex> delete_clock(clock)
      {:ok, %Clock{}}

      iex> delete_clock(clock)
      {:error, %Ecto.Changeset{}}
  """
  def delete_clock(%Clock{} = clock) do
    Repo.delete(clock)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking clock changes.

  ## Examples

      iex> change_clock(clock)
      %Ecto.Changeset{data: %Clock{}}
  """
  def change_clock(%Clock{} = clock, attrs \\ %{}) do
    Clock.changeset(clock, attrs)
  end

  @doc """
  Returns a list of clocks for a specific user.

  ## Examples

      iex> get_clocks_for_user(1)
      [%Clock{}, ...]
  """
  def get_clocks_for_user(user_id) do
    Clock
    |> where([c], c.user_id == ^user_id)
    |> Repo.all()
  end

  @doc """
  Returns a list of clock periods (both clock in and clock out) for a specific user.

  ## Examples

      iex> get_clocks_for_user_with_sessions(1)
      [%ClockPeriod{}, ...]
  """
  def get_clocks_for_user_with_sessions(user_id) do
    ClockPeriod
    |> where(user_id: ^user_id)
    |> order_by(:inserted_at)  # Triez par la date d'insertion
    |> Repo.all()
  end

  @doc """
  Gets the latest clock entry for a specific user.

  ## Examples

      iex> get_latest_clock(1)
      %Clock{}

      iex> get_latest_clock(2)
      nil
  """
  def get_latest_clock(user_id) do
    Repo.one(from c in Clock,
      where: c.user_id == ^user_id,
      order_by: [desc: c.inserted_at],
      select: [:id, :status, :time, :user_id, :inserted_at, :updated_at],
      limit: 1
    )
  end

  def get_latest_clock_period(user_id) do
    ClockPeriod
    |> where(user_id: ^user_id)
    |> order_by(desc: :inserted_at)
    |> limit(1)
    |> Repo.one()
  end

  def get_clocks_for_user_period(user_id) do
    ClockPeriod
    |> where([c], c.user_id == ^user_id)
    |> Repo.all()
  end
end
