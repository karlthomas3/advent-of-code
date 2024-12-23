defmodule Aoc.Day12 do
  import Aoc.Utils

  # @test "RRRRIICCFF\nRRRRIICCCF\nVVRRRCCFFF\nVVRCCCJFFF\nVVVVCJJCFE\nVVIVCCJJEE\nVVIIICJJEE\nMIIIIIJJEE\nMIIISIJEEE\nMMMISSJEEE"

  @spec part1(String.t()) :: :ok
  def part1(input) do
    grid = split_into_grid(input)

    groups = find_groups(grid)

    groups
    |> Enum.map(&calc_area_perimeter/1)
    |> Enum.map(fn {a, p} -> a * p end)
    |> Enum.sum()
    |> IO.inspect()
  end

  @spec part2(String.t()) :: :ok
  def part2(input) do
    grid = split_into_grid(input)
    groups = find_groups(grid)

    groups
    |> Enum.map(&calc_area_sides/1)
    |> Enum.map(fn {a, s} -> a * s end)
    |> Enum.sum()
    |> IO.inspect()
  end

  @spec find_groups([[String.t()]]) :: [[{integer(), integer()}]]
  defp find_groups(grid) do
    {groups, _visited} =
      Enum.reduce(0..(length(grid) - 1), {[], MapSet.new()}, fn row, {groups, visited} ->
        Enum.reduce(0..(length(Enum.at(grid, 0)) - 1), {groups, visited}, fn col,
                                                                             {groups, visited} ->
          if MapSet.member?(visited, {row, col}) do
            {groups, visited}
          else
            element = value_from_grid_pos(grid, {row, col})
            {new_visited, group} = dfs(grid, {row, col}, element, visited, [])
            {[group | groups], MapSet.union(visited, new_visited)}
          end
        end)
      end)

    groups
  end

  @spec dfs([[String.t()]], {integer(), integer()}, String.t(), MapSet.t(), [
          {integer(), integer()}
        ]) ::
          {MapSet.t(), [{integer(), integer()}]}
  defp dfs(_grid, {row, col}, _element, visited, acc) when row < 0 or col < 0, do: {visited, acc}

  defp dfs(grid, {row, col}, element, visited, acc) do
    if row < 0 or col < 0 or row >= length(grid) or col >= length(Enum.at(grid, 0)) do
      {visited, acc}
    else
      if MapSet.member?(visited, {row, col}) or value_from_grid_pos(grid, {row, col}) != element do
        {visited, acc}
      else
        visited = MapSet.put(visited, {row, col})
        acc = [{row, col} | acc]

        neighbors = [
          {row - 1, col},
          {row + 1, col},
          {row, col - 1},
          {row, col + 1}
        ]

        Enum.reduce(neighbors, {visited, acc}, fn neighbor, {visited, acc} ->
          dfs(grid, neighbor, element, visited, acc)
        end)
      end
    end
  end

  @spec calc_area_perimeter(list({integer(), integer()})) :: {integer(), integer()}
  defp calc_area_perimeter(positions) do
    area = length(positions)

    perimeter =
      Enum.reduce(positions, 0, fn {row, col}, acc ->
        neighbors = [
          {row - 1, col},
          {row + 1, col},
          {row, col - 1},
          {row, col + 1}
        ]

        shared_edges = Enum.count(neighbors, fn neighbor -> neighbor in positions end)
        acc + (4 - shared_edges)
      end)

    {area, perimeter}
  end

  # THIS FUNCTION IS WRONG AND NEEDS TO BE FIXED
  # LATER...
  @spec calc_area_sides(list({integer(), integer()})) :: {integer(), integer()}
  defp calc_area_sides(positions) do
    area = length(positions)

    sides =
      Enum.reduce(positions, MapSet.new(), fn {row, col}, acc ->
        neighbors = [
          {row - 1, col},
          {row + 1, col},
          {row, col - 1},
          {row, col + 1}
        ]

        s = Enum.count(neighbors, fn neighbor -> neighbor not in positions end)
        acc + s
      end)

    {area, sides}
  end
end
