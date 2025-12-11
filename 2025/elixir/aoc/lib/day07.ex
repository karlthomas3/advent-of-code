defmodule Aoc.Day07 do
  import Aoc.Utils

  @spec part1(String.t()) :: integer()
  def part1(input) do
    input
    |> split_by_line()
    |> make_grid()
    |> parse_map()
    # |> IO.inspect(limit: :infinity)
    |> count_splits()
  end

  @spec part2(String.t()) :: integer()
  def part2(input) do
    input
    |> split_by_line()
    |> make_grid()
    |> parse_map()
    |> count_paths()
  end

  defp trace_beams(grid_map) do
    orig = grid_map
    # debug_counts(orig)

    new_map =
      orig
      |> Enum.reduce(orig, fn
        {{x, y}, "."}, acc ->
          if Map.get(orig, {x, y - 1}) == "|" do
            Map.put(acc, {x, y}, "|")
          else
            acc
          end

        {{x, y}, "^"}, acc ->
          if Map.get(orig, {x, y - 1}) == "|" do
            acc
            |> maybe_put(orig, {x - 1, y})
            |> maybe_put(orig, {x + 1, y})
          else
            acc
          end

        {{x, y}, "S"}, acc ->
          maybe_put(acc, orig, {x, y + 1})

        _, acc ->
          acc
      end)

    new_map
  end

  defp maybe_put(acc, orig, coord) do
    if Map.get(orig, coord) == "." do
      Map.put(acc, coord, "|")
    else
      acc
    end
  end

  defp parse_map(old_map) do
    new_map = trace_beams(old_map)
    if old_map == new_map, do: new_map, else: parse_map(new_map)
  end

  defp count_splits(map) do
    Enum.count(map, fn
      {{x, y}, "^"} -> Map.get(map, {x, y - 1}) == "|"
      _ -> false
    end)
  end

  defp count_paths(map) when is_map(map) do
    case Enum.find(map, fn {_coord, val} -> val == "S" end) do
      nil ->
        0

      {{sx, sy}, _val} ->
        bottom_y = Map.keys(map) |> Enum.max_by(&elem(&1, 1)) |> elem(1)
        {count, _memo} = count_paths_from({sx, sy + 1}, map, %{}, bottom_y)
        count
    end
  end

  # base case
  defp count_paths_from({_, y} = coord, _grid, memo, bottom_y) when y == bottom_y do
    {1, Map.put(memo, coord, 1)}
  end

  # cached
  defp count_paths_from(coord, grid, memo, _bottom_y) do
    case Map.fetch(memo, coord) do
      {:ok, c} -> {c, memo}
      :error -> do_count_paths_from(coord, grid, memo)
    end
  end

  defp do_count_paths_from({x, y} = coord, grid, memo) do
    case Map.get(grid, coord) do
      nil ->
        # off-map is not an exit per your rule
        {0, Map.put(memo, coord, 0)}

      "S" ->
        count_paths_from(
          {x, y + 1},
          grid,
          memo,
          Enum.max_by(Map.keys(grid), &elem(&1, 1)) |> elem(1)
        )

      "|" ->
        count_paths_from(
          {x, y + 1},
          grid,
          memo,
          Enum.max_by(Map.keys(grid), &elem(&1, 1)) |> elem(1)
        )

      "^" ->
        {lcount, memo} = follow_side({x - 1, y}, grid, memo)
        {rcount, memo} = follow_side({x + 1, y}, grid, memo)
        total = lcount + rcount
        {total, Map.put(memo, coord, total)}

      _ ->
        {0, Map.put(memo, coord, 0)}
    end
  end

  defp follow_side(coord, grid, memo) do
    case Map.get(grid, coord) do
      v when v in ["|", "^", "S"] ->
        count_paths_from(coord, grid, memo, Enum.max_by(Map.keys(grid), &elem(&1, 1)) |> elem(1))

      _ ->
        {0, memo}
    end
  end

  # defp debug_counts(orig) do
  #   IO.inspect(Enum.take(orig, 200), label: "sample kvs")
  #   IO.inspect(Enum.uniq(Map.values(orig)), label: "unique chars")

  #   dots_above_pipe =
  #     Enum.count(orig, fn
  #       {{x, y}, "."} -> Map.get(orig, {x, y - 1}) == "|"
  #       _ -> false
  #     end)

  #   hats_ready =
  #     Enum.count(orig, fn
  #       {{x, y}, "^"} ->
  #         Map.get(orig, {x, y - 1}) == "|" and
  #           (Map.get(orig, {x - 1, y}) == "." or Map.get(orig, {x + 1, y}) == ".")

  #       _ ->
  #         false
  #     end)

  #   IO.inspect({dots_above_pipe, hats_ready}, label: "counts (dots with | above, ^ ready)")
  # end
end
