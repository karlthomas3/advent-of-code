defmodule Aoc.Day03 do
  import Aoc.Utils

  @spec part1(String.t()) :: integer()
  def part1(input) do
    input
    |> split_by_line()
    |> Enum.map(&String.to_integer/1)
    |> Enum.map(&biggest_num/1)
    |> Enum.sum()
  end

  @spec part2(String.t()) :: integer()
  def part2(input) do
    input
    |> split_by_line()
    |> Enum.map(&String.to_integer/1)
    |> Enum.map(&biggest_twelve/1)
    |> Enum.sum()
  end

  defp biggest_num(num) do
    digits = Integer.digits(num)

    pairs =
      for {a, i} <- Enum.with_index(digits),
          {b, j} <- Enum.with_index(digits),
          i < j,
          do: 10 * a + b

    Enum.max(pairs)
  end

  @spec biggest_twelve(integer()) :: integer()
  defp biggest_twelve(num) do
    digits = Integer.digits(num)
    k = 12

    if length(digits) <= k do
      num
    else
      digits
      |> greedy_select(k, [])
      |> Integer.undigits()
    end
  end

  defp greedy_select(_digits, 0, acc), do: Enum.reverse(acc)

  defp greedy_select(digits, remaining, acc) do
    max_search_index = length(digits) - remaining

    {digit, idx} =
      digits
      |> Enum.with_index()
      |> Enum.take(max_search_index + 1)
      |> Enum.max_by(fn {d, _i} -> d end)

    rest = Enum.drop(digits, idx + 1)
    greedy_select(rest, remaining - 1, [digit | acc])
  end
end
