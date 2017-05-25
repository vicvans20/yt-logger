defmodule YtLogger.Web.Router do
  use YtLogger.Web, :router
  use Coherence.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # Coherence!
  pipeline :protected do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session, protected: true
  end

  scope "/" do
    pipe_through :browser
    coherence_routes()
  end

  scope "/" do
    pipe_through :protected
    coherence_routes :protected
  end
  # ---------------

  scope "/", YtLogger.Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/logger", PageController, :history
    get "/oauth_app", PageController, :yt_oauth
  end

  scope "/", YtLogger.Web do
    pipe_through :protected

    # add protected resources below
    resources "/privates", MyProject.PrivateController
  end

end
