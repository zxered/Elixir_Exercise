defmodule RemoteControlCar do
  @enforce_keys [:battery_percentage, :distance_driven_in_meters]
  defstruct [
    :nickname,
    battery_percentage: 100,
    distance_driven_in_meters: 0
  ]

  def new(nickname \\ "none"), do: %{do_new() | nickname: nickname}
  
  def display_distance(remote_car = %__MODULE__{}) do
    distance = remote_car.distance_driven_in_meters
    "#{distance} meters"
  end

  def display_battery(remote_car = %__MODULE__{}) do
    battery = remote_car.battery_percentage
    case battery do
      0 -> "Battery empty"
      _ -> "Battery at #{battery}%"
    end
  end

  def drive(remote_car = %__MODULE__{}) do
    if remote_car.battery_percentage == 0 do
      remote_car
    else
      new_battery = remote_car.battery_percentage - 1
      new_distance = remote_car.distance_driven_in_meters + 20
      
      %{
        remote_car |
        battery_percentage: new_battery,
        distance_driven_in_meters: new_distance
      }
    end
  end

  defp do_new() do
    %__MODULE__{
      battery_percentage: 100,
      distance_driven_in_meters: 0
    }
  end
end
