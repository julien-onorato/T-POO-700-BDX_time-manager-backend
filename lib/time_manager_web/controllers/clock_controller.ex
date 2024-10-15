defmodule TimeManagerWeb.ClockController do
  use TimeManagerWeb, :controller

  alias TimeManager.Clocks
  alias TimeManager.Clocks.{Clock, ClockPeriod}
  alias TimeManager.Repo

  # GET /api/clocks/:userID
  def show(conn, %{"userID" => user_id}) do
    clock_periods = Clocks.get_clocks_for_user_period(user_id)

    if clock_periods != [] do
      conn
      |> put_status(:ok)
      |> json(%{
        status: "success",
        message: "Clock periods retrieved successfully.",
        clock_periods: clock_periods
      })
    else
      conn
      |> put_status(:not_found)
      |> json(%{
        status: "error",
        message: "No clock periods found for the specified user."
      })
    end
  end

  def create(conn, %{"userID" => user_id, "clock_in" => clock_in}) do
    user_id = String.to_integer(user_id)

    case DateTime.from_iso8601(clock_in) do
      {:ok, clock_in_dt, 0} -> # 0 indique aucun décalage de fuseau horaire
        changeset = ClockPeriod.changeset(%ClockPeriod{}, %{clock_in: clock_in_dt, user_id: user_id})

        case Repo.insert(changeset) do
          {:ok, clock_period} ->
            conn
            |> put_status(:created)
            |> json(%{
              status: "success",
              message: "Clock created successfully.",
              clock_period: clock_period
            })

          {:error, changeset} ->
            errors = Enum.map(changeset.errors, fn {field, {message, _}} ->
              "#{field} #{message}"
            end)

            conn
            |> put_status(:unprocessable_entity)
            |> json(%{
              status: "error",
              message: "Failed to create clock.",
              errors: errors
            })
        end

      {:error, _} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{
          status: "error",
          message: "Invalid clock_in format."
        })
    end
  end


  # POST /api/clocks/:userID/clock_out
  def clock_out(conn, %{"userID" => user_id}) do
    user_id = String.to_integer(user_id)

    case Clocks.get_latest_clock_period(user_id) do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{
          status: "error",
          message: "No clock in progress for the specified user."
        })

      %ClockPeriod{clock_out: nil} = clock_period ->
        clock_out_time = DateTime.utc_now()

        clock_period_changeset = ClockPeriod.changeset(clock_period, %{clock_out: clock_out_time})

        case Repo.update(clock_period_changeset) do
          {:ok, updated_clock_period} ->
            conn
            |> put_status(:ok)
            |> json(%{
              status: "success",
              message: "Clocked out successfully.",
              clock_period: updated_clock_period
            })

          {:error, changeset} ->
            errors = Enum.map(changeset.errors, fn {field, {message, _}} ->
              "#{field} #{message}"
            end)

            conn
            |> put_status(:unprocessable_entity)
            |> json(%{
              status: "error",
              message: "Failed to record clock out.",
              errors: errors
            })
        end

      %ClockPeriod{clock_out: _} ->
        conn
        |> put_status(:bad_request)
        |> json(%{
          status: "error",
          message: "User is already clocked out."
        })
    end
  end



  def options(conn, _params) do
    conn
    |> put_resp_header("allow", "GET, POST, OPTIONS")
    |> send_resp(204, "")
  end
end
