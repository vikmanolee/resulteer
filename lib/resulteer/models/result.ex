defmodule Resulteer.Models.Result do
  alias __MODULE__

  defstruct [
    :id,
    :div,
    :season,
    :date,
    :home_team,
    :away_team,
    :ft_hg,
    :ft_ag,
    :ft_r,
    :ht_hg,
    :ht_ag,
    :ht_r
  ]

  def new([id, div, season, date, homeTeam, awayTeam, fTHG, fTAG, fTR, hTHG, hTAG, hTR]),
    do: %Result{
      id: id,
      div: div,
      season: season,
      date: date,
      home_team: homeTeam,
      away_team: awayTeam,
      ft_hg: String.to_integer(fTHG),
      ft_ag: String.to_integer(fTAG),
      ft_r: fTR,
      ht_hg: String.to_integer(hTHG),
      ht_ag: String.to_integer(hTAG),
      ht_r: hTR
    }
end
