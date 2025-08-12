defmodule BoutiqueSuggestions do
  def get_combinations(tops, bottoms, options \\ []) do
    total = Keyword.get(options, :maximum_price, 100)
    
    for top <- tops,
        bottom <- bottoms,
        top.base_color != bottom.base_color,
        top.price + bottom.price <= total
    do
      {top, bottom}
    end
  end
end
