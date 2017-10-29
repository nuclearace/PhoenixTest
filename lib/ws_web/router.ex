defmodule WsWeb.Router do
  use WsWeb, :router
  alias WsWeb.AuthErrorHandler

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :authentication do
    plug Guardian.Plug.Pipeline, otp_app: :ws,
                                 module: LoginAPIController,
                                 error_handler: AuthErrorHandler,
                                 key: "memes"
    plug Guardian.Plug.VerifyCookie, claims: %{"typ" => "access"}, realm: :none
    plug Guardian.Plug.EnsureAuthenticated
    plug Guardian.Plug.LoadResource, ensure: true
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", WsWeb do
    pipe_through [:browser, :authentication]

    get "/", PageController, :index
  end

  scope "/users", WsWeb do
    pipe_through :browser

    get "/new", UserController, :new
    get "/login", LoginController, :new
  end

   scope "/api", WsWeb do
     pipe_through :api

     resources "/users", UserAPIController, except: [:new, :edit]
     post "/users/login", LoginAPIController, :create
   end
end
