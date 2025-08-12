defmodule Username do
  def sanitize([]), do: []
  def sanitize([hd | tl]) do
    case hd do
      hd when hd >= 97 and hd <= 122 or hd == 95 -> [hd] ++ sanitize(tl)
      ?ä -> [?a, ?e] ++ sanitize(tl)
      ?ö -> [?o, ?e] ++ sanitize(tl)
      ?ü -> [?u, ?e] ++ sanitize(tl)
      ?ß -> [?s, ?s] ++ sanitize(tl)
      _ -> sanitize(tl)
    end
  end
end
