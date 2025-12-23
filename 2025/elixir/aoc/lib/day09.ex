defmodule Aoc.Day09 do
  import Aoc.Utils

  @spec part1(String.t()) :: integer()
  def part1(input) do
    coords =
      input
      |> split_by_line()
      |> Enum.map(&String.split(&1, ","))
      |> Enum.map(fn [x, y] ->
        {String.to_integer(x), String.to_integer(y)}
      end)

    pairs =
      for {p1, i} <- Enum.with_index(coords),
          {p2, j} <- Enum.with_index(coords),
          i < j,
          do: {rect_area(p1, p2), p1, p2}

    {area, _, _} =
      pairs
      |> Enum.max_by(&elem(&1, 0))

    area
  end

  @spec part2(String.t()) :: integer()
  def part2(input) do
    input && 42
  end

  # defp dist({x1, y1}, {x2, y2}) do
  #   abs(x1 - x2) + abs(y1 - y2)
  # end

  defp rect_area({x1, y1}, {x2, y2}) do
    (abs(x1 - x2) + 1) * (abs(y1 - y2) + 1)
  end
end
