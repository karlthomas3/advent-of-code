defmodule Aoc.Day07 do
  import Aoc.Utils

  @spec part1(String.t()) :: :ok
  def part1(input) do
    lines =
      input
      |> split_by_newline
      |> Enum.map(fn line ->
        [total_string, num_string] = String.split(line, ":")

        total = String.to_integer(total_string)

        nums =
          num_string
          |> String.split(" ", trim: true)
          |> Enum.map(&String.to_integer/1)

        {total, nums}
      end)

    lines
    |> Enum.filter(&find_combinations/1)
    |> Enum.map(fn {total, _nums} -> total end)
    |> Enum.sum()
    |> IO.puts()
  end

  @spec find_combinations({integer, integer}) :: boolean()
  defp find_combinations(line) do
    {total, nums} = line
    operators = ["+", "*"]
    slots = length(nums) - 1

    generate_combinations(operators, slots)
    |> Enum.any?(fn ops ->
      evaluate(nums, ops) == total
    end)
  end

  @spec generate_combinations([String.t()], integer()) :: [String.t()]
  defp generate_combinations(_operators, 0), do: [[]]

  @spec generate_combinations([String.t()], integer()) :: [String.t()]
  defp generate_combinations(operators, n) do
    for op <- operators, rest <- generate_combinations(operators, n - 1), do: [op | rest]
  end

  @spec evaluate([integer()], [String.t()]) :: integer()
  defp evaluate([num | rest], [op | ops]) do
    result = apply_operator(num, hd(rest), op)
    evaluate([result | tl(rest)], ops)
  end

  @spec evaluate([integer()], [String.t()]) :: integer()
  defp evaluate([result], []), do: result

  @spec apply_operator(integer(), integer(), String.t()) :: integer()
  defp apply_operator(a, b, "+"), do: a + b
  defp apply_operator(a, b, "*"), do: a * b
end
