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

  scope "/api/swagger" do
    forward "/", PhoenixSwagger.Plug.SwaggerUI, otp_app: :resulteer, swagger_file: "swagger.json"
  end

  def swagger_info do
    %{
      info: %{
        version: "1.0",
        title: "The Sports Resulteer"
      }
    }
  end
end
