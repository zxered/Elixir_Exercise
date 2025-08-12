defmodule FreelancerRates do
  def daily_rate(hourly_rate), do: 8.0 * hourly_rate

  def apply_discount(before_discount, discount), do: before_discount * (1.0 - discount * 0.01)

  def monthly_rate(hourly_rate, discount), do: trunc(Float.ceil(apply_discount(22.0 * daily_rate(hourly_rate), discount), 0))

  def days_in_budget(budget, hourly_rate, discount), do: Float.floor(budget / apply_discount(daily_rate(hourly_rate), discount), 1)
end
