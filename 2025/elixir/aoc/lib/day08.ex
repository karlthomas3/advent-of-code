defmodule Aoc.Day08 do
  import Aoc.Utils

  @spec part1(String.t()) :: integer()
  def part1(input) do
    junctions =
      split_by_line(input)
      |> Enum.map(fn line ->
        [x, y, z] =
          String.split(line, ",")
          |> Enum.map(&String.to_integer/1)

        {x, y, z}
      end)

    pairs = find_closest(junctions, 1000)

    sets =
      Enum.reduce(pairs, [], fn {_dist, p, q}, sets ->
        add_pair_to_sets(sets, p, q)
      end)

    sets
    |> Enum.map(&MapSet.size/1)
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.product()
  end

  @spec part2(String.t()) :: integer()
  def part2(input) do
    junctions =
      split_by_line(input)
      |> Enum.map(fn line ->
        [x, y, z] =
          String.split(line, ",")
          |> Enum.map(&String.to_integer/1)

        {x, y, z}
      end)

    pairs = find_closest(junctions)

    result =
      Enum.reduce_while(pairs, [], fn {_d, p, q}, sets ->
        new_sets = add_pair_to_sets(sets, p, q)

        cond do
          new_sets == sets -> {:cont, sets}
          length(new_sets) == 1 -> {:halt, {p, q}}
          true -> {:cont, new_sets}
        end
      end)

    case result do
      {p, q} -> elem(p, 0) * elem(q, 0)
      _ -> 0
    end
  end

  # check distance between two 3D points
  @spec dist({integer(), integer(), integer()}, {integer(), integer(), integer()}) :: integer()
  defp dist({x1, y1, z1}, {x2, y2, z2}) do
    dx = x2 - x1
    dy = y2 - y1
    dz = z2 - z1
    dx * dx + dy * dy + dz * dz
  end

  # find k closest pairs of points
  @spec find_closest([{integer(), integer(), integer()}], integer() | :infinity) :: [
          {integer(), {integer(), integer(), integer()}, {integer(), integer(), integer()}}
        ]
  defp find_closest(points, k \\ :infinity) do
    pairs =
      for {p1, i} <- Enum.with_index(points),
          {p2, j} <- Enum.with_index(points),
          i < j,
          do: {dist(p1, p2), p1, p2}

    pairs = Enum.sort_by(pairs, &elem(&1, 0))

    if k == :infinity, do: pairs, else: Enum.take(pairs, k)
  end

  # get index of set containing point
  @spec set_index([MapSet.t()], {integer(), integer(), integer()}) :: integer() | nil
  defp set_index(sets, elem), do: Enum.find_index(sets, &MapSet.member?(&1, elem))

  # check if points are in a set. add to set or create new set
  defp add_pair_to_sets(sets, p, q) do
    case {set_index(sets, p), set_index(sets, q)} do
      {nil, nil} ->
        sets ++ [MapSet.new([p, q])]

      {i, nil} ->
        List.replace_at(sets, i, MapSet.put(Enum.at(sets, i), q))

      {nil, j} ->
        List.replace_at(sets, j, MapSet.put(Enum.at(sets, j), p))

      {i, j} when i == j ->
        sets

      {i, j} ->
        merged = MapSet.union(Enum.at(sets, i), Enum.at(sets, j))
        min_idx = min(i, j)
        max_idx = max(i, j)

        sets
        |> List.replace_at(min_idx, merged)
        |> List.delete_at(max_idx)
    end
  end
end
