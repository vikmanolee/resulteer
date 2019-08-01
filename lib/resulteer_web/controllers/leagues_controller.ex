defmodule ResulteerWeb.LeaguesController do
  use ResulteerWeb, :controller
  use PhoenixSwagger

  alias Resulteer.Repository

  def swagger_definitions do
    %{
      League:
        swagger_schema do
          title("League")
          description("A league - season pair")

          properties do
            id(:string, "League ID")
            season(:string, "Season ID")
            title(:string, "Full title")
          end

          example(%{
            id: "E0",
            season: "201617",
            title: "Premier League 2016-2017"
          })
        end,
      LeaguesResponse:
        swagger_schema do
          title("LeaguesResponse")
          description("Response schema for available Leagues")
          property(:leagues, Schema.array(:League), "The Leagues details")
        end,
      Result:
        swagger_schema do
          title("Result")
          description("A soccer Result")

          properties do
            awayTeam(:string, "The away team`s name")
            date(:string, "The date of the fixture in DD/MM/YYYY format")
            fullTimeAwayGoals(:integer, "The number of goals the away team scored at full time")
            fullTimeHomeGoals(:integer, "The number of goals the home team scored at full time")
            fullTimeResult(:string, "The full time result `H`/`A`/`D`")
            halfTimeAwayGoals(:integer, "The number of goals the away team scored at half time")
            halfTimeHomeGoals(:integer, "The number of goals the home team scored at half time")
            halfTimeResult(:string, "The half time result `H`/`A`/`D`")
            homeTeam(:string, "The home team'` name")
          end

          example(%{
            awayTeam: "Cadiz",
            date: "19/08/2016",
            fullTimeAwayGoals: 1,
            fullTimeHomeGoals: 1,
            fullTimeResult: "D",
            halfTimeAwayGoals: 0,
            halfTimeHomeGoals: 0,
            halfTimeResult: "D",
            homeTeam: "Almeria"
          })
        end,
      ResultsResponse:
        swagger_schema do
          title("ResultsResponse")
          description("Response schema for available Results")
          property(:Results, Schema.array(:Result), "The Result details")
        end
    }
  end

  swagger_path(:index) do
    get("/api/leagues")
    summary("List Leagues")
    description("List available league - season pairs")
    produces("application/json")

    response(200, "OK", Schema.ref(:LeaguesResponse),
      example: %{
        leagues: [
          %{
            id: 1,
            name: "Joe",
            updated_at: "2017-02-12T13:45:23Z"
          },
          %{
            id: 2,
            name: "Jack",
            updated_at: "2017-02-15T23:15:43Z"
          }
        ]
      }
    )
  end

  def index(conn, _params) do
    leagues = Repository.get_leagues()

    render(conn, "index.json", leagues: leagues)
  end

  swagger_path(:results) do
    get("/api/leagues/{div}/{season}/results")
    summary("List Results")
    description("List available league - season pairs")
    produces("application/json")
    produces("application/x-protobuf")

    parameters do
      div(:path, :string, "League ID", required: true, example: "E0")
      season(:path, :string, "Season ID", required: true, example: "201617")
    end

    response(200, "OK", Schema.ref(:ResultsResponse),
      example: %{
        results: [
          %{
            awayTeam: "Cadiz",
            date: "19/08/2016",
            fullTimeAwayGoals: 1,
            fullTimeHomeGoals: 1,
            fullTimeResult: "D",
            halfTimeAwayGoals: 0,
            halfTimeHomeGoals: 0,
            halfTimeResult: "D",
            homeTeam: "Almeria"
          },
          %{
            awayTeam: "Getafe",
            date: "19/08/2016",
            fullTimeAwayGoals: 1,
            fullTimeHomeGoals: 1,
            fullTimeResult: "D",
            halfTimeAwayGoals: 0,
            halfTimeHomeGoals: 0,
            halfTimeResult: "D",
            homeTeam: "Mirandes"
          }
        ]
      }
    )
  end

  def results(conn, %{"div" => league, "season" => season} = params) do
    results = Repository.get_results(league, season)

    format = Map.get(params, "format", "json")

    render(conn, "results." <> format, results: results)
  end
end
