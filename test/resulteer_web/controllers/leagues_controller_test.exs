defmodule ResulteerWeb.LeaguesControllerTest do
  use ResulteerWeb.ConnCase

  test "index/2 responds with all leagues", %{conn: conn} do
    response =
      conn
      |> get("api/leagues")
      |> json_response(200)

    expected = %{
      "leagues" => [
        %{"id" => "E0", "season" => "201617", "title" => "Premier League 2016-2017"}
      ]
    }

    assert response == expected
  end

  test "results/2 responds with requested results", %{conn: conn} do
    response =
      conn
      |> get("api/leagues/E0/201617/results")
      |> json_response(200)

    expected = %{
      "results" => [
        %{
          "awayTeam" => "Swansea",
          "date" => "13/08/2016",
          "fullTimeAwayGoals" => 1,
          "fullTimeHomeGoals" => 0,
          "fullTimeResult" => "A",
          "halfTimeAwayGoals" => 0,
          "halfTimeHomeGoals" => 0,
          "halfTimeResult" => "D",
          "homeTeam" => "Burnley"
        },
        %{
          "awayTeam" => "West Brom",
          "date" => "13/08/2016",
          "fullTimeAwayGoals" => 1,
          "fullTimeHomeGoals" => 0,
          "fullTimeResult" => "A",
          "halfTimeAwayGoals" => 0,
          "halfTimeHomeGoals" => 0,
          "halfTimeResult" => "D",
          "homeTeam" => "Crystal Palace"
        }
      ]
    }

    assert response == expected
  end
end
