defmodule Aoc.Day05 do
  @spec part1(String.t()) :: :ok
  def part1(input) do
    [part1, part2] = String.split(input, "\n\n", trim: true)

    rules =
      part1
      |> String.split("\n")
      |> Enum.map(&String.split(&1, "|"))

    updates =
      part2
      |> String.split("\n", trim: true)
      |> Enum.map(&String.split(&1, ",", trim: true))

    total =
      updates
      |> Enum.map(&check_order(&1, rules))
      |> Enum.map(&String.to_integer/1)
      |> Enum.sum()

    IO.inspect(total)
  end

  @spec check_order([String.t()], [[String.t()]]) :: String.t()
  defp check_order(line, rules) do
    new_rules = filter_rules(line, rules)

    broken_rules =
      new_rules
      |> Enum.map(fn [r1, r2] ->
        if Enum.find_index(line, &(&1 == r1)) > Enum.find_index(line, &(&1 == r2)) do
          1
        else
          0
        end
      end)
      |> Enum.sum()

    if broken_rules > 0 do
      "0"
    else
      find_middle(line)
    end
  end

  @spec filter_rules([String.t()], [[String.t()]]) :: [[String.t()]]
  defp filter_rules(line, rules) do
    Enum.filter(rules, fn [h | t] -> Enum.member?(line, h) || Enum.member?(line, t) end)
  end

  @spec find_middle([String.t()]) :: String.t()
  defp find_middle(list) do
    mid_index = div(length(list), 2)
    Enum.at(list, mid_index)
  end
end
