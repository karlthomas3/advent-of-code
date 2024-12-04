defmodule Aoc.Day03 do
  @spec part1(String.t()) :: :ok
  def part1(input) do
    regex = ~r/mul\((\d{1,3}),(\d{1,3})\)/

    Regex.scan(regex, input)
    |> Enum.map(fn [_full_match, x, y] -> String.to_integer(x) * String.to_integer(y) end)
    |> Enum.sum()
    |> IO.puts()
  end

  @spec part2(String.t()) :: :ok
  def part2(input) do
    regex = ~r/do\(\)|don't\(\)|mul\((\d{1,3}),(\d{1,3})\)/
    matches = Regex.scan(regex, input)

    {_, result} =
      Enum.reduce(matches, {true, []}, fn
        ["do()"], {_, acc} ->
          {true, acc}

        ["don't()"], {_, acc} ->
          {false, acc}

        ["mul(" <> _ = _full_match, x, y], {true, acc} ->
          {true, [String.to_integer(x) * String.to_integer(y) | acc]}

        ["mul(" <> _ = _full_match, _x, _y], {false, acc} ->
          {false, acc}
      end)

    result
    |> Enum.sum()
    |> IO.puts()
  end
end
