defmodule Aoc.Day10 do
  import Aoc.Utils

  @spec part1(String.t()) :: :ok
  def part1(input) do
    input
    |> split_into_grid(true)
    |> count_all_paths()
    |> IO.puts()
  end

  @spec part2(Sting.t()) :: :ok
  def part2(input) do
    input
    |> split_into_grid(true)
    |> count_all_distinct_paths()
    |> IO.puts()
  end

  @spec in_bounds?([[integer()]], {integer(), integer()}) :: boolean()
  defp in_bounds?(grid, {x, y}) do
    x >= 0 and y >= 0 and x < length(grid) and y < length(Enum.at(grid, 0))
  end

  @spec get_directions([[String.t()]], {integer(), integer()}) :: [{integer(), integer()}]
  defp get_directions(grid, {x, y}) do
    directions = [
      # up
      {-1, 0},
      # down
      {1, 0},
      # left
      {0, -1},
      # right
      {0, 1}
    ]

    directions
    |> Enum.map(fn {dx, dy} ->
      {x + dx, y + dy}
    end)
    |> Enum.filter(&in_bounds?(grid, &1))
  end

  @spec check_directions([[integer()]], {integer(), integer()}) :: [{integer(), integer()}]
  defp check_directions(grid, {x, y}) do
    central_value = value_from_grid_pos(grid, {x, y})
    target_value = central_value + 1

    get_directions(grid, {x, y})
    |> Enum.filter(fn {adj_x, adj_y} ->
      value_from_grid_pos(grid, {adj_x, adj_y}) == target_value
    end)
  end

  @spec count_paths_from_pos([[integer()]], {integer(), integer()}, MapSet.t()) :: MapSet.t()
  defp count_paths_from_pos(grid, {x, y}, visited) do
    if value_from_grid_pos(grid, {x, y}) == 9 do
      MapSet.put(visited, {x, y})
    else
      check_directions(grid, {x, y})
      |> Enum.reduce(visited, fn {adj_x, adj_y}, acc ->
        count_paths_from_pos(grid, {adj_x, adj_y}, acc)
      end)
    end
  end

  @spec count_all_paths([[integer()]]) :: integer()
  defp count_all_paths(grid) do
    for x <- 0..(length(grid) - 1),
        y <- 0..(length(Enum.at(grid, 0)) - 1),
        value_from_grid_pos(grid, {x, y}) == 0,
        reduce: 0 do
      acc ->
        unique_nines = count_paths_from_pos(grid, {x, y}, MapSet.new())
        acc + MapSet.size(unique_nines)
    end
  end

  @spec count_distinct_paths_from_pos([[integer()]], {integer(), integer()}) :: integer()
  defp count_distinct_paths_from_pos(grid, {x, y}) do
    cur_val = value_from_grid_pos(grid, {x, y})

    if cur_val == 9 do
      1
    else
      check_directions(grid, {x, y})
      |> Enum.reduce(0, fn {adj_x, adj_y}, acc ->
        acc + count_distinct_paths_from_pos(grid, {adj_x, adj_y})
      end)
    end
  end

  @spec count_all_distinct_paths([[integer()]]) :: integer()
  defp count_all_distinct_paths(grid) do
    for x <- 0..(length(grid) - 1),
        y <- 0..(length(Enum.at(grid, 0)) - 1),
        value_from_grid_pos(grid, {x, y}) == 0,
        reduce: 0 do
      acc -> acc + count_distinct_paths_from_pos(grid, {x, y})
    end
  end
end
