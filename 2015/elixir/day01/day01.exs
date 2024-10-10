defmodule Day01 do
  def part1(input) do
    input
    |> String.split("", trim: true)
    |> floors(0)
  end

  def read_input(file_path) do
    case File.read(file_path) do
      {:ok, content} -> content
      {:error, reason} -> IO.puts("Error reading file: #{reason}")
    end
  end

  defp floors([], floor), do: floor
  defp floors(["(" | t], floor), do: floors(t, floor + 1)
  defp floors([")" | t], floor), do: floors(t, floor - 1)
  defp floors([_ | t], floor), do: floors(t, floor)

  def part2(input) do
    input
    |> String.split("", trim: true)
    |> basement(0, 0)
  end

  defp basement([], _floor, _pos), do: -1
  defp basement([_ | _], -1, pos), do: pos
  defp basement(["(" | t], floor, pos), do: basement(t, floor + 1, pos + 1)
  defp basement([")" | t], floor, pos), do: basement(t, floor - 1, pos + 1)
  defp basement([_ | t], floor, pos), do: basement(t, floor, pos)
end

# usage
file_path = "input.txt"
input = Day01.read_input(file_path)
result1 = Day01.part1(input)
result2 = Day01.part2(input)
IO.puts("Part 1: #{result1}")
IO.puts("Part 2: #{result2}")
