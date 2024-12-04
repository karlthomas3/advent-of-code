defmodule Aoc.Day02 do
  import Aoc.Utils

  @spec part1(String.t()) :: :ok
  def part1(input) do
    input
    |> split_by_newline()
    |> Enum.map(&split_nums/1)
    |> Enum.map(&safe?/1)
    |> Enum.sum()
    |> IO.puts()
  end

  @spec part2(String.t()) :: :ok
  def part2(input) do
    input
    |> split_by_newline()
    |> Enum.map(&split_nums/1)
    |> Enum.map(&safe2?/1)
    |> Enum.sum()
    |> IO.puts()
  end

  @spec split_nums(String.t()) :: [integer]
  defp split_nums(line) do
    line
    |> String.split(" ", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  @spec safe?([integer]) :: integer
  defp safe?(nums) do
    if check_increasing(nums) || check_decreasing(nums) do
      1
    else
      0
    end
  end

  @spec safe2?([integer]) :: integer
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

  @spec check_increasing([integer]) :: boolean()
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

  @spec check_decreasing([integer]) :: boolean()
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

  @spec problem_dampener([integer]) :: boolean()
  defp problem_dampener(nums) do
    Enum.any?(0..(length(nums) - 1), fn i ->
      new_nums = List.delete_at(nums, i)
      check_increasing(new_nums) || check_decreasing(new_nums)
    end)
  end
end
