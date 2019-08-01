defmodule Resulteer.Models.League do
  @moduledoc """
  The League model as it is extracted from the Data source.

  This is an intermediate model of a part of the extracted Data,
  representing the league - season pair.

  The properties are two columns of the CSV data file.
  """
  alias __MODULE__

  defstruct [
    :div,
    :season
  ]

  @type t :: %League{}

  @league_names %{
    "SP1" => "La Liga",
    "SP2" => "La Liga 2",
    "E0" => "Premier League",
    "D1" => "Bundesliga"
  }

  @doc """
  The real world name of a league id (:div)
  """
  @spec real_name(binary) :: binary
  def real_name(id),
    do: Map.get(@league_names, id)
end
