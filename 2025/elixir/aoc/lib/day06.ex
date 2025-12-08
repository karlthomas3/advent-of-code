defmodule Aoc.Day06 do
  import Aoc.Utils

  # @test_input "123 328  51 64 \n 45 64  387 23 \n  6 98  215 314\n*   +   *   +"

  @spec part1(String.t()) :: integer()
  def part1(input) do
    input
    |> split_by_line()
    |> Enum.map(&String.split(&1, " ", trim: true))
    |> Enum.zip()
    |> Enum.map(&math/1)
    |> Enum.sum()
  end

  @spec part2(String.t()) :: integer()
  def part2(input) do
    input
    |> cephalapod()
    |> Enum.map(&math/1)
    |> Enum.sum()
  end

  defp math(tuple) when is_tuple(tuple) do
    list = Tuple.to_list(tuple)
    {op, nums_list} = List.pop_at(list, -1)

    case op do
      "+" ->
        nums_list
        |> Enum.map(&String.replace(&1, "x", ""))
        |> Enum.map(&String.to_integer/1)
        |> Enum.sum()

      "*" ->
        nums_list
        |> Enum.map(&String.replace(&1, "x", ""))
        |> Enum.map(&String.to_integer/1)
        |> Enum.reduce(1, &Kernel.*/2)
    end
  end

  defp cephalapod(input) do
    {ops, lines} =
      input
      |> String.replace(" ", "x")
      |> split_by_line()
      |> Enum.map(&String.graphemes/1)
      |> List.pop_at(-1)

    slices =
      Enum.zip(lines)
      |> Enum.map(&Tuple.to_list/1)
      |> Enum.map(&Enum.join(&1, ""))
      |> split_into_groups()
      |> Enum.map(&Enum.reverse/1)

    ops =
      Enum.reject(ops, &(&1 == "x"))

    Enum.zip(slices, ops)
    |> Enum.map(fn {slice, op} -> slice ++ [op] end)
    |> Enum.map(&List.to_tuple/1)
  end

  defp split_into_groups(slices) do
    slices
    |> Enum.chunk_by(fn s -> String.match?(s, ~r/^x+$/) end)
    |> Enum.reject(fn group -> Enum.all?(group, &String.match?(&1, ~r/^x+$/)) end)
  end
end
