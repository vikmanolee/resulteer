defmodule Resulteer.Data do
  alias NimbleCSV.RFC4180, as: CSV
  alias Resulteer.Models.Result

  @file_path "priv/Data.csv"

  def get_leagues() do
    all_results()
    |> Stream.map(fn %{div: div, season: season} -> %{div: div, season: season} end)
    |> Stream.dedup()
    |> Enum.to_list()
  end

  def get_results(league, season) do
    all_results()
    |> Stream.filter(fn
      %{div: ^league, season: ^season} -> true
      _ -> false
    end)
    |> Enum.to_list()
  end

  def all_results() do
    @file_path
    |> File.stream!()
    |> CSV.parse_stream()
    |> Stream.map(&Result.new/1)
  end
end
