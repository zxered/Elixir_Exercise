defmodule Username do
  def sanitize([]), do: []
  def sanitize([hd | tl]) when hd >= 97 and hd <= 122 or hd == 95, do: [hd] ++ sanitize(tl)
  def sanitize([hd | tl]) when [hd] == ~c"ä", do: [?a, ?e] ++ sanitize(tl)
  def sanitize([hd | tl]) when [hd] == ~c"ö", do: [?o, ?e] ++ sanitize(tl)
  def sanitize([hd | tl]) when [hd] == ~c"ü", do: [?u, ?e] ++ sanitize(tl)
  def sanitize([hd | tl]) when [hd] == ~c"ß", do: [?s, ?s] ++ sanitize(tl)
  def sanitize([_hd | tl]), do: sanitize(tl)
end
