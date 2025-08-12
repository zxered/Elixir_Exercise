defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    cond do
      data == nil or path == nil -> nil
      
      true ->
        case String.split(path, ".", parts: 2) do
          [key] -> data[key]
          [key, rest] -> extract_from_path(data[key], rest)
        end
    end
  end

  def get_in_path(data, path) do
    path_ = String.split(path, ".")
    Kernel.get_in(data, path_)
  end
end
