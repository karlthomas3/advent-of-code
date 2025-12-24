defmodule Aoc.Day11 do
  import Aoc.Utils

  # @test_input "aaa: you hhh\nyou: bbb ccc\nbbb: ddd eee\nccc: ddd eee fff\nddd: ggg\neee: out\nfff: out\nggg: out\nhhh: ccc fff iii\niii: out"
  # @test_input2 "svr: aaa bbb\naaa: fft\nfft: ccc\nbbb: tty\ntty: ccc\nccc: ddd eee\nddd: hub\nhub: fff\neee: dac\ndac: fff\nfff: ggg hhh\nggg: out\nhhh: out"

  @spec part1(String.t()) :: integer()
  def part1(input) do
    input
    |> split_by_line()
    |> parse_servers()
    |> Enum.into(%{})
    |> travel()
  end

  @spec part2(String.t()) :: integer()
  def part2(input) do
    input
    |> split_by_line()
    |> parse_servers()
    |> Enum.into(%{})
    |> travel2()
  end

  @spec parse_servers([String.t()]) :: [{String.t(), [String.t()]}]
  defp parse_servers(lst) do
    lst
    |> Enum.map(&parse_server/1)
  end

  @spec parse_server(String.t()) :: {String.t(), [String.t()]}
  defp parse_server(line) do
    [server, rest] = String.split(line, ":", trim: true)
    exits = String.split(rest, " ", trim: true)

    {server, exits}
  end

  defp travel(map, pos \\ "you") do
    case pos do
      "out" -> 1
      _ -> map[pos] |> Enum.map(&travel(map, &1)) |> Enum.sum()
    end
  end

  defp travel2(map, cur \\ {"svr", false, false}) do
    {count, _memo} = travel2_memo(map, cur, %{})
    count
  end

  defp travel2_memo(map, {pos, fft, dac} = state, memo) do
    case Map.fetch(memo, state) do
      {:ok, cached} ->
        {cached, memo}

      :error ->
        {value, memo_after_children} =
          cond do
            pos == "out" ->
              val = if fft and dac, do: 1, else: 0
              {val, memo}

            pos == "fft" ->
              Enum.reduce(Map.get(map, pos, []), {0, memo}, fn nb, {acc, m} ->
                {child_count, m2} = travel2_memo(map, {nb, true, dac}, m)
                {acc + child_count, m2}
              end)

            pos == "dac" ->
              Enum.reduce(Map.get(map, pos, []), {0, memo}, fn nb, {acc, m} ->
                {child_count, m2} = travel2_memo(map, {nb, fft, true}, m)
                {acc + child_count, m2}
              end)

            true ->
              Enum.reduce(Map.get(map, pos, []), {0, memo}, fn nb, {acc, m} ->
                {child_count, m2} = travel2_memo(map, {nb, fft, dac}, m)
                {acc + child_count, m2}
              end)
          end

        {value, Map.put(memo_after_children, state, value)}
    end
  end

  # defp travel2(map, {pos, fft, dac} = cur \\ {"svr", false, false}) do
  #   case cur do
  #     {"out", true, true} ->
  #       1

  #     {"out", _, _} ->
  #       0

  #     {"fft", _fft, dac} ->
  #       map[pos] |> Enum.reduce(0, fn nb, acc -> acc + travel2(map, {nb, true, dac}) end)

  #     {"dac", fft, _dac} ->
  #       map[pos] |> Enum.reduce(0, fn nb, acc -> acc + travel2(map, {nb, fft, true}) end)

  #     _ ->
  #       map[pos] |> Enum.reduce(0, fn nb, acc -> acc + travel2(map, {nb, fft, dac}) end)
  #   end
  # end
end
