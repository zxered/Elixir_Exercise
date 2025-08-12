defmodule Lasagna do
  def expected_minutes_in_oven(), do: 40
  def remaining_minutes_in_oven(t), do: expected_minutes_in_oven() - t
  def preparation_time_in_minutes(n), do: 2 * n
  def total_time_in_minutes(n, t), do: preparation_time_in_minutes(n) + t
  def alarm(), do: "Ding!"
end
