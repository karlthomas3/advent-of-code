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
      |> Enum.filter(&(&1 != ""))
      |> Enum.map(&String.to_integer/1)
      |> Enum.sum()

    IO.puts(total)
  end

  @spec part2(String.t()) :: :ok
  def part2(input) do
    [p1, p2] = String.split(input, "\n\n", trim: true)

    rules =
      p1
      |> String.split("\n", trim: true)
      |> Enum.map(&String.split(&1, "|"))

    updates =
      p2
      |> String.split("\n", trim: true)
      |> Enum.map(&String.split(&1, ",", trim: true))

    incorrect =
      updates
      |> Enum.filter(&(check_order(&1, rules) == ""))

    corrected =
      incorrect
      |> Enum.map(&correct_order(&1, rules))

    total =
      corrected
      |> Enum.map(&find_middle/1)
      |> Enum.map(&String.to_integer/1)
      |> Enum.sum()

    IO.puts(total)
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
      ""
    else
      find_middle(line)
    end
  end

  @spec filter_rules([String.t()], [[String.t()]]) :: [[String.t()]]
  defp filter_rules(line, rules) do
    Enum.filter(rules, fn [h | t] ->
      Enum.member?(line, h) || Enum.member?(line, t)
    end)
  end

  @spec find_middle([String.t()]) :: String.t()
  defp find_middle(list) do
    mid_index = div(length(list), 2)
    Enum.at(list, mid_index)
  end

  @spec correct_order([String.t()], [[String.t()]]) :: [String.t()]
  defp correct_order(line, rules) do
    sorted =
      Enum.sort(line, fn a, b ->
        Enum.any?(rules, fn [r1, r2] ->
          (r1 == a and r2 == b) or
            (r1 == b and r2 == a and
               Enum.find_index(line, &(&1 == r1)) < Enum.find_index(line, &(&1 == r2)))
        end)
      end)

    if check_order(sorted, rules) == "" do
      correct_order(sorted, rules)
    else
      sorted
    end
  end
end
