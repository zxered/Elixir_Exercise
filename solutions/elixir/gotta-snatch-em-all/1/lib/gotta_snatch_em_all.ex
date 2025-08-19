defmodule GottaSnatchEmAll do
  @type card :: String.t()
  @type collection :: MapSet.t(card())

  @spec new_collection(card()) :: collection()
  def new_collection(card), do: MapSet.new([card])

  @spec add_card(card(), collection()) :: {boolean(), collection()}
  def add_card(card, collection) do
    {MapSet.member?(collection, card), MapSet.put(collection, card)}
  end

  @spec trade_card(card(), card(), collection()) :: {boolean(), collection()}
  def trade_card(your_card, their_card, collection) do
    {
      MapSet.member?(collection, your_card) && !MapSet.member?(collection, their_card),
      collection |> MapSet.delete(your_card) |> MapSet.put(their_card)
    }
  end

  @spec remove_duplicates([card()]) :: [card()]
  def remove_duplicates(cards) do
    cards |> MapSet.new() |> MapSet.to_list()
  end

  @spec extra_cards(collection(), collection()) :: non_neg_integer()
  def extra_cards(your_collection, their_collection) do
    MapSet.difference(your_collection, their_collection) |> MapSet.size()
  end

  @spec boring_cards([collection()]) :: [card()]
  def boring_cards(collections) do
    Enum.reduce(collections, MapSet.new([]),
      fn x, acc ->
        case MapSet.to_list(acc) do
          [] -> x
          _ -> MapSet.intersection(x, acc)
        end
      end
    )
    |> MapSet.to_list()
    |> Enum.sort()
  end

  @spec total_cards([collection()]) :: non_neg_integer()
  def total_cards(collections) do
    Enum.reduce(collections, MapSet.new([]), &MapSet.union/2)
    |> MapSet.size()
  end

  @spec split_shiny_cards(collection()) :: {[card()], [card()]}
  def split_shiny_cards(collection) do
    {shiny, non_shiny} = MapSet.split_with(collection, &String.starts_with?(&1, "Shiny"))
    
    {
      shiny |> MapSet.to_list() |> Enum.sort(),
      non_shiny |> MapSet.to_list() |> Enum.sort()
    }
  end
end
