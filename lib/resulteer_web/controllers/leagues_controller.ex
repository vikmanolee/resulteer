defmodule ResulteerWeb.LeaguesController do
  use ResulteerWeb, :controller

  alias Resulteer.Data

  def index(conn, _params) do
    leagues = Data.get_leagues()

    render(conn, "index.json", leagues: leagues)
  end

  def results(conn, %{"div" => league, "season" => season} = params) do
    results = Data.get_results(league, season)

    format = Map.get(params, "format", "json")

    render(conn, "results." <> format, results: results)
  end
end
