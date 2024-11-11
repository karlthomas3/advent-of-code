defmodule AoC do
  @input "./input.txt"

  def part1 do
    File.read!(@input)
    |> String.split("\n", trim: true)
    |> Enum.count(&is_nice?/1)
    |> IO.puts()
  end

  def part2 do
    File.read!(@input)
    |> String.split("\n", trim: true)
    |> Enum.count(&is_nice2?/1)
    |> IO.puts()
  end

  defp is_nice?(string) do
    three_vowels?(string) && check_double_letter?(string) && check_forbidden_strings?(string)
  end

  defp is_nice2?(string) do
    two_pairs?(string) && one_letter_repeat?(string)
  end

  defp three_vowels?(string) do
    String.match?(string, ~r/[aeiou].*[aeiou].*[aeiou]/)
  end

  defp check_double_letter?(string) do
    String.match?(string, ~r/(.)\1/)
  end

  def check_forbidden_strings?(string) do
    !String.match?(string, ~r/ab|cd|pq|xy/)
  end

  def two_pairs?(string) do
    String.match?(string, ~r/(..).*\1/)
  end

  def one_letter_repeat?(string) do
    String.match?(string, ~r/(.).\1/)
  end
end

AoC.part1()
AoC.part2()
