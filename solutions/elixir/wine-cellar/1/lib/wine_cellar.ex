defmodule WineCellar do
  def explain_colors do
    [white: "Fermented without skin contact.",
    red: "Fermented with skin contact using dark-colored grapes.",
    rose: "Fermented with some skin contact, but not enough to qualify as a red wine."]
  end

  def filter(cellar, color, opt \\ []) do
    wines = Keyword.get_values(cellar, color)
    
    wines =
    if yr = Keyword.get(opt, :year) do
      filter_by_year(wines, yr)
    else
      wines
    end
    
    wines =
    if cntr = Keyword.get(opt, :country) do
      filter_by_country(wines, cntr)
    else
      wines
    end
    
    wines
  end

  # The functions below do not need to be modified.

  defp filter_by_year(wines, year)
  defp filter_by_year([], _year), do: []

  defp filter_by_year([{_, year, _} = wine | tail], year) do
    [wine | filter_by_year(tail, year)]
  end

  defp filter_by_year([{_, _, _} | tail], year) do
    filter_by_year(tail, year)
  end

  defp filter_by_country(wines, country)
  defp filter_by_country([], _country), do: []

  defp filter_by_country([{_, _, country} = wine | tail], country) do
    [wine | filter_by_country(tail, country)]
  end

  defp filter_by_country([{_, _, _} | tail], country) do
    filter_by_country(tail, country)
  end
end
