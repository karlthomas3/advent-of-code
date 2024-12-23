defmodule Aoc.Day11 do
  @spec part1(String.t()) :: :ok
  def part1(input) do
    # test = "125 17"

    stones =
      input
      |> String.trim()
      |> String.split(" ", trim: true)
      |> Stream.map(&String.to_integer/1)

    count =
      stones
      |> blink(25)
      |> count_stream()

    IO.inspect(count)
  end

  @spec part2(String.t()) :: :ok
  def part2(input) do
    stones =
      input
      |> String.trim()
      |> String.split(" ", trim: true)
      |> Stream.map(&String.to_integer/1)

    count =
      stones
      |> blink(75)
      |> count_stream()

    IO.inspect(count)
  end

  @spec apply_rules(integer()) :: [integer()]
  defp apply_rules(num) do
    cond do
      num == 0 ->
        [1]

      even_length?(num) ->
        split_number(num)

      true ->
        [num * 2024]
    end
  end

  @spec even_length?(integer()) :: boolean()
  defp even_length?(number) do
    l = number |> Integer.digits() |> length()
    rem(l, 2) == 0
  end

  @spec split_number(integer()) :: [integer()]
  defp split_number(number) do
    digits = Integer.digits(number)
    mid = div(length(digits), 2)
    {left, right} = Enum.split(digits, mid)
    [Integer.undigits(left), Integer.undigits(right)]
  end

  @spec blink(Enumerable.t(), integer()) :: Enumerable.t()
  defp blink(stones, 0), do: stones

  defp blink(stones, times) do
    Stream.iterate(stones, fn stones ->
      stones
      |> Task.async_stream(&apply_rules/1, max_concurrency: System.schedulers_online())
      |> Stream.flat_map(fn {:ok, result} -> result end)
    end)
    |> Stream.drop(times)
    |> Stream.take(1)
    |> Stream.flat_map(& &1)
  end

  defp count_stream(stream) do
    stream
    |> Enum.reduce_while(0, fn _element, acc ->
      IO.inspect(acc)
      {:cont, acc + 1}
    end)
  end
end
