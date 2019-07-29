defmodule ResulteerWeb.LeaguesViewTest do
  use ResulteerWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  @fetched_results [
    %Resulteer.Models.Result{
      away_team: "Swansea",
      date: "13/08/2016",
      div: "E0",
      ft_ag: 1,
      ft_hg: 0,
      ft_r: "A",
      home_team: "Burnley",
      ht_ag: 0,
      ht_hg: 0,
      ht_r: "D",
      id: "1685",
      season: "201617"
    },
    %Resulteer.Models.Result{
      away_team: "West Brom",
      date: "13/08/2016",
      div: "E0",
      ft_ag: 1,
      ft_hg: 0,
      ft_r: "A",
      home_team: "Crystal Palace",
      ht_ag: 0,
      ht_hg: 0,
      ht_r: "D",
      id: "1686",
      season: "201617"
    }
  ]

  @fetched_leagues [
    %{div: "SP1", season: "201617"},
    %{div: "SP1", season: "201516"},
    %{div: "SP2", season: "201617"}
  ]

  test "renders index.json" do
    assert render(ResulteerWeb.LeaguesView, "index.json", %{leagues: @fetched_leagues}) == %{
             leagues: [
               %{id: "SP1", season: "201617", title: "La Liga 2016-2017"},
               %{id: "SP1", season: "201516", title: "La Liga 2015-2016"},
               %{id: "SP2", season: "201617", title: "La Liga 2 2016-2017"}
             ]
           }
  end

  test "renders results.json" do
    assert render(ResulteerWeb.LeaguesView, "results.json", %{results: @fetched_results}) ==
             %{
               results: [
                 %{
                   awayTeam: "Swansea",
                   date: "13/08/2016",
                   fullTimeAwayGoals: 1,
                   fullTimeHomeGoals: 0,
                   fullTimeResult: "A",
                   halfTimeAwayGoals: 0,
                   halfTimeHomeGoals: 0,
                   halfTimeResult: "D",
                   homeTeam: "Burnley"
                 },
                 %{
                   awayTeam: "West Brom",
                   date: "13/08/2016",
                   fullTimeAwayGoals: 1,
                   fullTimeHomeGoals: 0,
                   fullTimeResult: "A",
                   halfTimeAwayGoals: 0,
                   halfTimeHomeGoals: 0,
                   halfTimeResult: "D",
                   homeTeam: "Crystal Palace"
                 }
               ]
             }
  end

  test "renders results.proto" do
    output =
      render_to_string(ResulteerWeb.LeaguesView, "results.proto", %{
        results: @fetched_results
      })

    assert ResulteerWeb.Protobuf.Messages.Results.decode(output) ==
             %ResulteerWeb.Protobuf.Messages.Results{
               results: [
                 %ResulteerWeb.Protobuf.Messages.Results.Result{
                   awayTeam: "Swansea",
                   date: "13/08/2016",
                   fullTimeAwayGoals: 1,
                   fullTimeHomeGoals: 0,
                   fullTimeResult: "A",
                   halfTimeAwayGoals: 0,
                   halfTimeHomeGoals: 0,
                   halfTimeResult: "D",
                   homeTeam: "Burnley"
                 },
                 %ResulteerWeb.Protobuf.Messages.Results.Result{
                   awayTeam: "West Brom",
                   date: "13/08/2016",
                   fullTimeAwayGoals: 1,
                   fullTimeHomeGoals: 0,
                   fullTimeResult: "A",
                   halfTimeAwayGoals: 0,
                   halfTimeHomeGoals: 0,
                   halfTimeResult: "D",
                   homeTeam: "Crystal Palace"
                 }
               ]
             }
  end
end
