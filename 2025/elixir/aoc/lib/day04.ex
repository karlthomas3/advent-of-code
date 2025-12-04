defmodule Aoc.Day04 do
  import Aoc.Utils

  @spec part1(String.t()) :: integer()
  def part1(input) do
    grid =
      input
      |> split_by_line()
      |> make_grid()

    count =
      grid
      |> Map.filter(fn {_key, value} -> value == "@" end)
      |> Map.filter(fn {key, _value} -> movable?(grid, key) end)
      |> map_size()

    count
  end

  @spec part2(String.t()) :: integer()
  def part2(input) do
    grid =
      input
      |> split_by_line()
      |> make_grid()

    grid
    |> Map.filter(fn {_key, value} -> value == "@" end)
    |> can_move()
  end

  @spec make_grid([String.t()]) :: map()
  defp make_grid(list) do
    for {line, y} <- Enum.with_index(list),
        {char, x} <- String.graphemes(line) |> Enum.with_index(),
        into: %{},
        do: {{x, y}, char}
  end

  @spec movable?(map(), {integer(), integer()}) :: boolean()
  defp movable?(map, {x, y}) do
    # one in all directions
    occupied_count =
      [{-1, -1}, {0, -1}, {1, -1}, {-1, 0}, {1, 0}, {-1, 1}, {0, 1}, {1, 1}]
      |> Enum.map(fn {dx, dy} ->
        {x + dx, y + dy}
      end)
      # keep the ones that exist
      |> Enum.filter(&Map.has_key?(map, &1))
      # get the values
      |> Enum.map(&Map.get(map, &1))
      # how many are occupied?
      |> Enum.count(&(&1 == "@"))

    # movable if less than 4 occupied
    occupied_count < 4
  end

  defp can_move(map, count \\ 0) do
    movable =
      map
      |> Map.filter(fn {key, _value} -> movable?(map, key) end)

    case map_size(movable) do
      0 ->
        count

      _ ->
        new_map = Map.reject(map, fn {key, _value} -> movable?(map, key) end)
        can_move(new_map, count + map_size(movable))
    end
  end
end
