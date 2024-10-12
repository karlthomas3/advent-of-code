defmodule Day02 do
  def part1(input) do
    input
    |> read_input()
    |> format_input()
    |> Enum.map(&calculate_paper/1)
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> read_input()
    |> format_input()
    |> Enum.map(&calculate_ribbon/1)
    |> Enum.sum()
  end

  def read_input(file_path) do
    case File.read(file_path) do
      {:ok, content} -> content
      {:error, reason} -> IO.puts("Error reading file: #{reason}")
    end
  end

  def format_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, "x"))
  end

  def calculate_paper([l, w, h]) do
    lw = String.to_integer(l) * String.to_integer(w)
    wh = String.to_integer(w) * String.to_integer(h)
    hl = String.to_integer(h) * String.to_integer(l)
    2 * lw + 2 * wh + 2 * hl + Enum.min([lw, wh, hl])
  end

  def calculate_ribbon([l, w, h]) do
    l = String.to_integer(l)
    w = String.to_integer(w)
    h = String.to_integer(h)
    [side1, side2, _] = Enum.sort([l, w, h])
    wrap = 2 * side1 + 2 * side2
    bow = l * w * h
    wrap + bow
  end
end

# usage
result1 = Day02.part1("input.txt")
result2 = Day02.part2("input.txt")
IO.puts("Part 1: #{result1}")
IO.puts("Part 2: #{result2}")
