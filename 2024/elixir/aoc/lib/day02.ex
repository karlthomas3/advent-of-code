defmodule Aoc.Day02 do
  import Aoc.Utils

  def part1(input) do
    input
    |> split_by_newline()
    |> Enum.map(&split_nums/1)
    |> Enum.map(&safe?/1)
    |> Enum.sum()
    |> IO.puts()
  end

  def part2(input) do
    input
    |> split_by_newline()
    |> Enum.map(&split_nums/1)
    |> Enum.map(&safe2?/1)
    |> Enum.sum()
    |> IO.puts()
  end

  defp split_nums(line) do
    line
    |> String.split(" ", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  defp safe?(nums) do
    if check_increasing(nums) || check_decreasing(nums) do
      1
    else
      0
    end
  end

  defp safe2?(nums) do
    if check_increasing(nums) || check_decreasing(nums) do
      1
    else
      if problem_dampener(nums) do
        1
      else
        0
      end
    end
  end

  defp check_increasing([_]), do: true
  defp check_increasing([]), do: true

  defp check_increasing([h1, h2 | t]) do
    dif = abs(h1 - h2)

    if(h1 < h2 && dif > 0 && dif < 4) do
      check_increasing([h2 | t])
    else
      false
    end
  end

  defp check_decreasing([_]), do: true
  defp check_decreasing([]), do: true

  defp check_decreasing([h1, h2 | t]) do
    dif = abs(h1 - h2)

    if(h1 > h2 && dif > 0 && dif < 4) do
      check_decreasing([h2 | t])
    else
      false
    end
  end

  defp problem_dampener(nums) do
    Enum.any?(0..(length(nums) - 1), fn i ->
      new_nums = List.delete_at(nums, i)
      check_increasing(new_nums) || check_decreasing(new_nums)
    end)
  end
end
