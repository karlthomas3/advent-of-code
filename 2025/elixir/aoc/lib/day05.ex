defmodule Aoc.Day05 do
  import Aoc.Utils

  @spec part1(String.t()) :: integer()
  def part1(input) do
    {ranges, nums} = parse_input(input)

    nums
    |> Enum.filter(fn num -> is_fresh?(num, ranges) end)
    |> length()
  end

  @spec part2(String.t()) :: integer()
  def part2(input) do
    {ranges, _nums} = parse_input(input)

    ranges
    |> merge_ranges()
    |> Enum.map(fn {first, last} -> last - first + 1 end)
    |> Enum.sum()
  end

  defp parse_input(input) do
    [range_str, nums_str] = String.split(input, "\n\n", trim: true)

    ranges =
      split_by_line(range_str)
      |> Enum.map(fn line ->
        [first, last] = String.split(line, "-", trim: true)
        {String.to_integer(first), String.to_integer(last)}
      end)

    nums =
      nums_str
      |> split_by_line()
      |> Enum.map(&String.to_integer/1)

    {ranges, nums}
  end

  defp is_fresh?(number, ranges) do
    Enum.any?(ranges, fn {first, last} ->
      number >= first and number <= last
    end)
  end

  defp merge_ranges(ranges) do
    sorted =
      ranges
      |> Enum.sort(fn {a_start, _}, {b_start, _} -> a_start <= b_start end)

    Enum.reduce(sorted, [], fn {start, end_}, acc ->
      case acc do
        [] ->
          [{start, end_}]

        [{last_start, last_end} | rest] ->
          if start <= last_end + 1 do
            # overlapping or contiguous ranges, merge them
            [{last_start, max(last_end, end_)} | rest]
          else
            # non-overlapping range, add to list
            [{start, end_} | acc]
          end
      end
    end)
  end
end
