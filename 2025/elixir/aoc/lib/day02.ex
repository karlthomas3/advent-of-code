defmodule Aoc.Day02 do
  @type range :: %{first: integer(), last: integer()}

  @spec part1(String.t()) :: integer()
  def part1(input) do
    ranges =
      String.split(input, ",", trim: true)
      |> Enum.map(fn part ->
        [first, last] = String.split(part, "-") |> Enum.map(&String.to_integer/1)
        %{first: first, last: last}
      end)

    for %{first: first, last: last} <- ranges do
      Enum.filter(first..last, &repeated?/1)
    end
    |> List.flatten()
    |> Enum.sum()
  end

  @spec part2(String.t()) :: integer()
  def part2(input) do
    ranges =
      String.split(input, ",", trim: true)
      |> Enum.map(fn part ->
        [first, last] = String.split(part, "-") |> Enum.map(&String.to_integer/1)
        %{first: first, last: last}
      end)

    for %{first: first, last: last} <- ranges do
      Enum.filter(first..last, &multi_repeat?/1)
    end
    |> List.flatten()
    |> Enum.sum()
  end

  defp repeated?(num) do
    str = Integer.to_string(num)
    len = String.length(str)

    if rem(len, 2) == 0 do
      mid = div(len, 2)
      first_half = String.slice(str, 0, mid)
      second_half = String.slice(str, mid, mid)
      first_half == second_half
    else
      false
    end
  end

  defp multi_repeat?(num) do
    str = Integer.to_string(num)
    Regex.match?(~r/^(.+?)\1+$/, str)
  end
end
