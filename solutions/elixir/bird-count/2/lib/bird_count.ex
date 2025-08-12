defmodule BirdCount do
  def today(list) do
    hd(list ++ [nil])
  end

  def increment_day_count(list) do
    cond do
      list == [] -> [1]
      [head | tail] = list -> [head+1 | tail]
    end
  end

  def has_day_without_birds?([]), do: false
  def has_day_without_birds?([hd | tl]), do: hd == 0 || has_day_without_birds?(tl) 
  
  def total([]), do: 0
  def total([hd | tl]), do: hd + total(tl)

  def busy_days([]), do: 0
  def busy_days([hd | tl]) when hd >= 5, do: busy_days(tl) + 1
  def busy_days([_hd | tl]), do: busy_days(tl)
end
