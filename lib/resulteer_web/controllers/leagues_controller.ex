defmodule ResulteerWeb.LeaguesController do
  use ResulteerWeb, :controller

  alias Resulteer.Repository

  def index(conn, _params) do
    leagues = Repository.get_leagues()

    render(conn, "index.json", leagues: leagues)
  end

  def results(conn, %{"div" => league, "season" => season} = params) do
    results = Repository.get_results(league, season)

    format = Map.get(params, "format", "json")

    render(conn, "results." <> format, results: results)
  end
end
