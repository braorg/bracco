defmodule Bracco.Router do
  use Bracco.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Bracco do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api", Bracco do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit]
    resources "/notes", NoteController, except: [:new, :edit]
  end
end
