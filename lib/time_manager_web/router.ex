defmodule TimeManagerWeb.Router do
  use TimeManagerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug CORSPlug
  end

  scope "/api", TimeManagerWeb do
    pipe_through :api

    options "/clocks/:userID", ClockController, :options

    #get "/users", UserController, :index
    #resources "/users", UserController, except: [:new, :edit, :index]

    # get "/workingtime/:userID", WorkingTimeController, :index
    get "/workingtime/", WorkingTimeController, :index

    get "/workingtime/:userID/:id", WorkingTimeController, :show
    # get "/workingtime/:userID", WorkingTimeController, :index
    post "/workingtime/:userID", WorkingTimeController, :create
    put "/workingtime/:id", WorkingTimeController, :update
    delete "/workingtime/:id", WorkingTimeController, :delete

    get "/clocks/:userID", ClockController, :show
    post "/clocks/:userID", ClockController, :create
    post "/clocks/:userID/out", ClockController, :clock_out
  end
end
