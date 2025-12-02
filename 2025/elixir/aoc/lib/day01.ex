defmodule Aoc.Day01 do
  import Aoc.Utils

  @spec part1(String.t()) :: integer()
  def part1(input) do
    split_by_line(input)
    |> traverse(50)
    |> Enum.count(&(&1 == 0))
  end

  @spec part2(String.t()) :: integer()
  def part2(input) do
    split_by_line(input)
    |> traverse2(50)
  end

  defp rotate(str, cur) do
    {dir, num} =
      String.split_at(str, 1)

    n = String.to_integer(num)

    case dir do
      "L" -> Integer.mod(cur - n, 100)
      "R" -> Integer.mod(cur + n, 100)
      _ -> cur
    end
  end

  defp rotate2(str, cur) do
    {dir, num} =
      String.split_at(str, 1)

    n = String.to_integer(num)

    passed_zero =
      case dir do
        "L" ->
          Integer.floor_div(cur - 1, 100) - Integer.floor_div(cur - n - 1, 100)

        "R" ->
          Integer.floor_div(cur + n, 100) - Integer.floor_div(cur, 100)
      end

    new_pos =
      case dir do
        "L" -> Integer.mod(cur - n, 100)
        "R" -> Integer.mod(cur + n, 100)
      end

    {new_pos, passed_zero}
  end

  defp traverse(instructions, start_cur) do
    Enum.scan(instructions, start_cur, fn instr, cur ->
      rotate(instr, cur)
    end)
  end

  defp traverse2(instructions, start_cur) do
    Enum.reduce(instructions, {start_cur, 0}, fn instr, {cur, total_passed} ->
      {next_cur, passed} = rotate2(instr, cur)
      {next_cur, total_passed + passed}
    end)
    |> elem(1)
  end
end
