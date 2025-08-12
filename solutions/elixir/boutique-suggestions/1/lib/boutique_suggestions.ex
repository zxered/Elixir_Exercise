defmodule BoutiqueSuggestions do
  def get_combinations(tops, bottoms, options \\ [maximum_price: 100.00]) do
    for top <- tops,
        bottom <- bottoms,
        top[:base_color] != bottom[:base_color],
        total = options[:maximum_price],
        top[:price] + bottom[:price] <= total
    do
      {top, bottom}
    end
  end
end
