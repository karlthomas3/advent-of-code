defmodule AoC do
  @input "iwrupvqb"

  def part1 do
    findNumber()
    |> IO.puts()
  end

  def part2 do
    findNumber2()
    |> IO.puts()
  end

  def md5(string) do
    :crypto.hash(:md5, string)
    |> Base.encode16()
    |> String.downcase()
  end

  def fiveZeroes?(string) do
    String.starts_with?(string, "00000")
  end

  def sixZeroes?(string) do
    String.starts_with?(string, "000000")
  end

  def findNumber do
    findNumber(@input, 1)
  end

  def findNumber2 do
    findNumber2(@input, 1)
  end

  def findNumber(input, number) do
    hash = md5(input <> Integer.to_string(number))

    case fiveZeroes?(hash) do
      true -> number
      _ -> findNumber(input, number + 1)
    end
  end

  def findNumber2(input, number) do
    hash = md5(input <> Integer.to_string(number))

    case sixZeroes?(hash) do
      true -> number
      _ -> findNumber2(input, number + 1)
    end
  end
end

AoC.part1()
AoC.part2()
