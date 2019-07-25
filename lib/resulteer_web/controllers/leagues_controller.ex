defmodule ResulteerWeb.LeaguesController do
  use ResulteerWeb, :controller

  alias Resulteer.Data

  def index(conn, params) do
    leagues = Data.get_leagues()

    format = Map.get(params, "format", "json")

    render(conn, "index.json", leagues: leagues)
  end

  def results(conn, %{"div" => league, "season" => season}) do
    results = Data.get_results(league, season)

    format = Map.get(params, "format", "json")

    render(conn, "results.json", results: results)
  end
end
