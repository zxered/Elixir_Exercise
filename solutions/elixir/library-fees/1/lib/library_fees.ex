defmodule LibraryFees do
  def datetime_from_string(string), do: NaiveDateTime.from_iso8601!(string)

  def before_noon?(datetime) do
    datetime
    |> NaiveDateTime.to_time()
    |> Time.before?(~T[12:00:00])
  end

  def return_date(checkout_datetime) do
    added =
    if before_noon?(checkout_datetime), do: 28, else: 29
    NaiveDateTime.add(checkout_datetime, added, :day)
    |> NaiveDateTime.to_date()
  end

  def days_late(planned_return_date, actual_return_datetime) do
    result =
    NaiveDateTime.to_date(actual_return_datetime)
    |> Date.diff(planned_return_date)
    #|> then(&((&1 + abs(&1)) / 2))
    
    if result > 0, do: result, else: 0
  end

  def monday?(datetime) do
    NaiveDateTime.to_date(datetime)
    |> Date.day_of_week() == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    return_date =
      return
      |> datetime_from_string()
    
    value =
      checkout
      |> datetime_from_string()
      |> return_date()
      |> days_late(return_date)
      |> Kernel.*(rate)
    
    if monday?(return_date), do: Float.floor(value * 0.5), else: value
  end
end
