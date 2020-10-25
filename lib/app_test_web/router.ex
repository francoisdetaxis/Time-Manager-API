defmodule AppTestWeb.Router do
  use AppTestWeb, :router

  pipeline :browser do
    plug CORSPlug, origin: "*"
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
#    TODO commented this to avoid CSRF Error
#    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug CORSPlug, origin: "*"
    plug :accepts, ["json"]
  end

  scope "/", AppTestWeb do
    pipe_through :browser

    get "/", PageController, :index
    #    TODO figure this out:
    #Add the resource to your :api scope in lib/app_test_web/router.ex:

  end

  # Other scopes may use custom stacks.
   scope "/api", AppTestWeb do
     pipe_through :api
     options "/users", UsersController, :options
     resources "/users", UsersController, except: [:new, :edit]

     post("/workingtimes/:usersId", WorkingtimesController, :create)
     get("/workingtimes/:usersId/:id", WorkingtimesController, :show)
     get("/workingtimes/:usersId", WorkingtimesController, :index)
     put("/workingtimes/:id", WorkingtimesController, :update)
     delete("/workingtimes/:id", WorkingtimesController, :delete)

     post("/clocks/:usersId", ClocksController, :create)
     get("/clocks/:usersId", ClocksController, :show)


    #post "/workingtimes/:usersid", WorkingtimesController, :create
   end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: AppTestWeb.Telemetry
    end
  end
end
