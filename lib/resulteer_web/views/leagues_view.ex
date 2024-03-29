defmodule ResulteerWeb.LeaguesView do
  use ResulteerWeb, :view

  alias __MODULE__
  alias Resulteer.Models.League
  alias ResulteerWeb.Protobuf.Messages.Results
  alias ResulteerWeb.Protobuf.Messages.Results.Result

  def render("index.json", %{leagues: leagues}) do
    %{
      leagues: render_many(leagues, LeaguesView, "league.json", as: :league)
    }
  end

  def render("league.json", %{league: league}) do
    %{
      id: league.div,
      season: league.season,
      title: render_title(league)
    }
  end

  def render("results.json", %{results: results}) do
    %{
      results: render_many(results, LeaguesView, "result", as: :result)
    }
  end

  def render("result", %{result: result}) do
    property_mapper(result)
  end

  def render("results.proto", %{results: results}) do
    results =
      Enum.map(
        results,
        fn result ->
          result
          |> property_mapper()
          |> Result.new()
        end
      )

    %{results: results}
    |> Results.new()
    |> Results.encode()
  end

  defp property_mapper(result) do
    %{
      date: result.date,
      homeTeam: result.home_team,
      awayTeam: result.away_team,
      fullTimeHomeGoals: result.ft_hg,
      fullTimeAwayGoals: result.ft_ag,
      fullTimeResult: result.ft_r,
      halfTimeHomeGoals: result.ht_hg,
      halfTimeAwayGoals: result.ht_ag,
      halfTimeResult: result.ht_r
    }
  end

  defp render_title(league) do
    {front, last} = String.split_at(league.season, -2)
    season = front <> "-20" <> last
    League.real_name(league.div) <> " " <> season
  end
end
