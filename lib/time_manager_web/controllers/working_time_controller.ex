defmodule TimeManagerWeb.WorkingTimeController do
  use TimeManagerWeb, :controller

  alias TimeManager.WorkingTimes
  alias TimeManager.Accounts
  alias TimeManager.Accounts.WorkingTime
  alias TimeManager.WorkingTimes.WorkingTime
  alias TimeManager.Repo

  # Fonction pour récupérer les heures de travail de tous les utilisateurs
  def index(conn, _params) do
    workingtimes = Accounts.list_all_workingtimes()
    render(conn, "index.json", workingtimes: workingtimes)
  end

  # GET /api/workingtime/:userID?start=XXX&end=YYY
  # def index(conn, %{"userID" => user_id, "start" => start_date, "end" => end_date}) do
  #   user_id = String.to_integer(user_id)

  #   with {:ok, start_datetime, _} <- DateTime.from_iso8601(start_date),
  #        {:ok, end_datetime, _} <- DateTime.from_iso8601(end_date) do

  #     workingtimes = WorkingTimes.get_workingtimes_for_user(user_id, start_datetime, end_datetime)
  #     render(conn, "index.json", %{workingtime: workingtimes})
  #   else
  #     _ ->
  #       conn
  #       |> put_status(:bad_request)
  #       |> json(%{error: "Invalid datetime format"})
  #   end
  # end

  # GET /api/workingtime/:userID
  # def index(conn, %{"userID" => user_id}) do
  #   case Integer.parse(user_id) do
  #     {user_id, ""} ->
  #       workingtimes = WorkingTimes.list_workingtime_by_id(user_id)

  #       json(conn, %{
  #         message: "Working times successfully fetched",
  #         workingtimes: workingtimes
  #       })

  #     :error ->
  #       conn
  #       |> put_status(:bad_request)
  #       |> json(%{error: "Invalid userID format"})
  #   end
  # end



  # GET /api/workingtime/:userID/:id
  def show(conn, %{"userID" => _user_id, "id" => id}) do
    workingtime = WorkingTimes.get_workingtime!(id)
    render(conn, "show.json", workingtime: workingtime)
  end

  # POST /api/workingtime/:userID
  def create(conn, %{"userID" => user_id, "workingtime" => workingtime_params}) do
    case WorkingTimes.create_working_time(Map.put(workingtime_params, "user_id", user_id)) do
      {:ok, workingtime} ->
        conn
        |> put_status(:created)
        |> json(%{
          message: "Working time created successfully",
          workingtime: workingtime
        })

      {:error, changeset} ->
        errors = changeset.errors
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{
          error: "Validation failed",
          errors: Enum.map(errors, fn {field, {message, _}} -> %{field: field, message: message} end)
        })
    end
  end

  # PUT /api/workingtime/:id

  def update(conn, %{"id" => id, "workingtime" => workingtime_params}) do
    working_time = WorkingTimes.get_workingtime!(id)

    case WorkingTimes.update_working_time(working_time, workingtime_params) do
      {:ok, working_time} ->
        conn
        |> put_status(:ok)
        |> json(%{message: "Working time updated successfully", workingtime: working_time})

      {:error, changeset} ->
        errors = Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
          Enum.reduce(opts, msg, fn {key, value}, acc ->
            String.replace(acc, "%{#{key}}", to_string(value))
          end)
        end)

        conn
        |> put_status(:unprocessable_entity)
        |> json(%{error: "Validation failed", errors: errors})
    end
  end


  # DELETE /api/workingtime/:id
  def delete(conn, %{"id" => id}) do
    case Repo.get(WorkingTimes.WorkingTime, id) do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{status: "error", message: "Working time not found."})

      workingtime ->
        case WorkingTimes.delete_working_time(workingtime) do
          {:ok, _workingtime} ->
            conn
            |> put_status(:ok)
            |> json(%{status: "success", message: "Working time deleted successfully."})

          {:error, changeset} ->
            errors = Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
              Enum.reduce(opts, msg, fn {key, value}, acc ->
                String.replace(acc, "%{#{key}}", to_string(value))
              end)
            end)

            conn
            |> put_status(:unprocessable_entity)
            |> json(%{status: "error", message: "Failed to delete working time.", errors: errors})
        end
    end
  end
end
