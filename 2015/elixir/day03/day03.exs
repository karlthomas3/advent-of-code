defmodule AoC do
  def part1(input) do
    input
    |> read_input()
    |> String.graphemes()
    |> visit(%{{0, 0} => true}, 0, 0)
    |> map_size()
  end

  def part2(input) do
    input
    |> read_input()
    |> String.graphemes()
    |> robo_visit(%{{0, 0} => true}, :santa, 0, 0, 0, 0)
    |> map_size()
  end

  def read_input(file_path) do
    case File.read(file_path) do
      {:ok, content} -> content
      {:error, reason} -> IO.puts("Error reading file: #{reason}")
    end
  end

  def visit(input, houses, x, y) do
    case input do
      [] ->
        houses

      [h | t] ->
        case h do
          ">" -> visit(t, Map.put(houses, {x + 1, y}, true), x + 1, y)
          "<" -> visit(t, Map.put(houses, {x - 1, y}, true), x - 1, y)
          "^" -> visit(t, Map.put(houses, {x, y + 1}, true), x, y + 1)
          "v" -> visit(t, Map.put(houses, {x, y - 1}, true), x, y - 1)
          _ -> visit(t, houses, x, y)
        end
    end
  end

  def robo_visit(input, houses, :santa, x1, y1, x2, y2) do
    case input do
      [] ->
        houses

      [h | t] ->
        case h do
          ">" -> robo_visit(t, Map.put(houses, {x1 + 1, y1}, true), :robo, x1 + 1, y1, x2, y2)
          "<" -> robo_visit(t, Map.put(houses, {x1 - 1, y1}, true), :robo, x1 - 1, y1, x2, y2)
          "^" -> robo_visit(t, Map.put(houses, {x1, y1 + 1}, true), :robo, x1, y1 + 1, x2, y2)
          "v" -> robo_visit(t, Map.put(houses, {x1, y1 - 1}, true), :robo, x1, y1 - 1, x2, y2)
          _ -> robo_visit(t, houses, :robo, x1, y1, x2, y2)
        end
    end
  end

  def robo_visit(input, houses, :robo, x1, y1, x2, y2) do
    case input do
      [] ->
        houses

      [h | t] ->
        case h do
          ">" -> robo_visit(t, Map.put(houses, {x2 + 1, y2}, true), :santa, x1, y1, x2 + 1, y2)
          "<" -> robo_visit(t, Map.put(houses, {x2 - 1, y2}, true), :santa, x1, y1, x2 - 1, y2)
          "^" -> robo_visit(t, Map.put(houses, {x2, y2 + 1}, true), :santa, x1, y1, x2, y2 + 1)
          "v" -> robo_visit(t, Map.put(houses, {x2, y2 - 1}, true), :santa, x1, y1, x2, y2 - 1)
          _ -> robo_visit(t, houses, :santa, x1, y1, x2, y2)
        end
    end
  end
end

# usage
result1 = AoC.part1("input.txt")
IO.puts("Part 1: #{result1}")

result2 = AoC.part2("input.txt")
IO.puts("Part 2: #{result2}")
