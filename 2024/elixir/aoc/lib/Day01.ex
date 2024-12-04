defmodule Aoc.Day01 do
  import Aoc.Utils

  @spec part1(String.t()) :: :ok
  def part1(input) do
    {left, right} =
      input
      |> split_columns()

    sLeft = Enum.sort(left)
    sRight = Enum.sort(right)

    distance =
      Enum.zip(sLeft, sRight)
      |> Enum.reduce(0, fn {l, r}, acc -> acc + abs(l - r) end)

    IO.puts(distance)
  end

  @spec part2(String.t()) :: :ok
  def part2(input) do
    {left, right} =
      input
      |> split_columns()

    right_frequencies = Enum.frequencies(right)

    similarity =
      Enum.map(left, fn num ->
        freq = right_frequencies[num] || 0
        num * freq
      end)
      |> Enum.sum()

    IO.puts(similarity)
  end

  @spec split_columns(String.t()) :: {[integer], [integer]}
  defp split_columns(input) do
    input
    |> split_by_newline()
    |> Enum.reduce({[], []}, fn line, {left_acc, right_acc} ->
      [l, r] = String.split(line, "   ", trim: true)

      {
        left_acc ++ [String.to_integer(l)],
        right_acc ++ [String.to_integer(r)]
      }
    end)
  end
end
