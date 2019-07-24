defmodule ResulteerWeb.Router do
  use ResulteerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ResulteerWeb do
    pipe_through :api
  end
end
