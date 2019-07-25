defmodule ResulteerWeb.Router do
  use ResulteerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ResulteerWeb do
    pipe_through :api

    get "/leagues", LeaguesController, :index
    get "/leagues/:div/:season/results", LeaguesController, :results
  end
end
