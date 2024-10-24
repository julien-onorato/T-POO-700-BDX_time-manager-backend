defmodule TimeManagerWeb.ClockJSON do
  alias TimeManager.Clocks.Clock

  @doc """
  Renders a list of clocks.
  """
  def index(%{clocks: clocks}) do
    Enum.map(clocks, fn clock ->
      %{
        id: clock.id,
        clock_in: clock.time,
        clock_out: clock.clock_out,
        user_id: clock.user_id
      }
    end)
  end

  @doc """
  Renders a single clock.
  """
  def show(%{clock: clock}) do
    %{data: data(clock)}
  end

  defp data(%Clock{} = clock) do
    %{
      id: clock.id,
      clock_in: clock.clock_in,
      clock_out: clock.clock_out,
      user_id: clock.user_id
    }
  end
end
