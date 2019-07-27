defmodule Resulteer.Repository do
  alias NimbleCSV.RFC4180, as: CSV
  alias Resulteer.Models.Result

  def data_file_path() do
    Application.get_env(:resulteer, :repository)
    |> Keyword.get(:path)
  end

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
    data_file_path()
    |> File.stream!()
    |> CSV.parse_stream()
    |> Stream.map(&Result.new/1)
  end
end
