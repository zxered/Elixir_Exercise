defmodule Username do
  def sanitize([]), do: []
  def sanitize([hd | tl]) do
    case hd do
      hd when hd >= ?a and hd <= ?z or hd == ?_ -> [hd | sanitize(tl)]
      ?ä -> ~c"ae" ++ sanitize(tl)
      ?ö -> ~c"oe" ++ sanitize(tl)
      ?ü -> ~c"ue" ++ sanitize(tl)
      ?ß -> ~c"ss" ++ sanitize(tl)
      _ -> sanitize(tl)
    end
  end
end
