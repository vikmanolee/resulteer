defmodule Resulteer.Repository do
  @moduledoc """
  A module that serves as a single reach point for the underlying data source of results.

  It exposes functions to get results, leagues and the data source file.

  The results are mapped as a `Resulteer.Models.Result` struct.
  """
  alias NimbleCSV.RFC4180, as: CSV
  alias Resulteer.Models.{League, Result}

  @doc """
  Returns the file path where the Data source file rests.

  This is set via config files under the application's `:repository, :path` key.
  """
  @spec data_file_path() :: binary
  def data_file_path() do
    Application.get_env(:resulteer, :repository)
    |> Keyword.get(:path)
  end

  @doc """
  Returns all the distinct league - season pairs in the Data source.
  """
  @spec get_leagues() :: [League.t()]
  def get_leagues() do
    all_results()
    |> Stream.map(fn %{div: div, season: season} -> %League{div: div, season: season} end)
    |> Stream.dedup()
    |> Enum.to_list()
  end

  @doc """
  Returns the results that match a certain league and season.
  """
  @spec get_results(binary, binary) :: [Result.t()]
  def get_results(league, season) do
    all_results()
    |> Stream.filter(fn
      %{div: ^league, season: ^season} -> true
      _ -> false
    end)
    |> Enum.to_list()
  end

  @doc """
  Returns a Stream that can return all the `Results` of the Data source.
  """
  @spec all_results() :: Stream.t()
  def all_results() do
    data_file_path()
    |> File.stream!()
    |> CSV.parse_stream()
    |> Stream.map(&Result.new/1)
  end
end
