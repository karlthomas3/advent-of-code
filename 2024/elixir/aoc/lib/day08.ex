defmodule Aoc.Day08 do
  import Aoc.Utils

  @spec part1(String.t()) :: :ok
  def part1(input) do
    grid = split_into_grid(input)

    node_map = find_nodes(grid)

    antinodes = find_all_antinodes(node_map)

    grid_height = length(grid)
    grid_width = length(List.first(grid))

    filtered_antinodes = filter_positions(antinodes, grid_width, grid_height)

    filtered_antinodes
    |> length()
    |> IO.puts()
  end

  @spec find_nodes([[String.t()]]) :: map()
  defp find_nodes(grid) do
    Enum.reduce(grid, %{}, fn row, acc ->
      Enum.reduce(Enum.with_index(row), acc, fn {char, col_index}, acc ->
        if char != "." do
          Map.update(
            acc,
            char,
            [{Enum.find_index(grid, &(&1 == row)), col_index}],
            fn positions ->
              [{Enum.find_index(grid, &(&1 == row)), col_index} | positions]
            end
          )
        else
          acc
        end
      end)
    end)
  end

  @spec calc_aligned_positions({integer(), integer()}, {integer(), integer()}) :: [
          {integer(), integer()}
        ]
  defp calc_aligned_positions({x1, y1}, {x2, y2}) do
    dx = x2 - x1
    dy = y2 - y1

    [
      {x1 + 2 * dx, y1 + 2 * dy},
      {x2 + 2 * -dx, y2 + 2 * -dy}
    ]
  end

  @spec generate_combinations(map()) :: [{{integer(), integer()}, {integer(), integer()}}]
  defp generate_combinations(positions_map) do
    for {_char, positions} <- positions_map,
        pos1 <- 0..(length(positions) - 2),
        pos2 <- (pos1 + 1)..(length(positions) - 1) do
      {Enum.at(positions, pos1), Enum.at(positions, pos2)}
    end
  end

  @spec find_antinodes(map()) :: [{integer(), integer()}]
  defp find_antinodes(positions_map) do
    positions_map
    |> generate_combinations()
    |> Enum.flat_map(fn {pos1, pos2} ->
      calc_aligned_positions(pos1, pos2)
    end)
  end

  @spec find_all_antinodes(map()) :: [{integer(), integer()}]
  defp find_all_antinodes(node_map) do
    node_map
    |> Enum.flat_map(fn {key, positions} ->
      find_antinodes(%{key => positions})
    end)
  end

  @spec filter_positions([{integer(), integer()}], integer(), integer()) :: [
          {integer(), integer()}
        ]
  defp filter_positions(positions, grid_width, grid_height) do
    positions
    |> Enum.filter(fn {x, y} ->
      x >= 0 and x < grid_width and y >= 0 and y < grid_height
    end)
    |> Enum.uniq()
  end
end
