defmodule TimeManagerWeb.Router do
  use TimeManagerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug CORSPlug
  end

  # Pipeline pour vérifier l'authentification
  pipeline :auth do
    plug TimeManagerWeb.Plugs.AuthenticateJWT
  end

  # Routes d'authentification
  scope "/api", TimeManagerWeb do
    pipe_through :api

    post "/auth/login", AuthController, :login
    post "/auth/register", AuthController, :register
  end

  # Routes nécessitant l'authentification
  scope "/api", TimeManagerWeb do
    pipe_through [:api]


    options "/clocks/:userID", ClockController, :options

    get "/current_user", UserController, :current_user
    get "/users", UserController, :index
    resources "/users", UserController, except: [:new, :edit, :index]

    get "/workingtime/", WorkingTimeController, :index

    get "/workingtime/:userID/:id", WorkingTimeController, :show
    get "/workingtime/:userID", WorkingTimeController, :index
    post "/workingtime/:userID", WorkingTimeController, :create
    put "/workingtime/:id", WorkingTimeController, :update
    delete "/workingtime/:id", WorkingTimeController, :delete

    get "/clocks/:userID", ClockController, :show
    post "/clocks/:userID", ClockController, :create
    post "/clocks/:userID/out", ClockController, :clock_out

    delete "/logout", UserController, :logout
  end
end
