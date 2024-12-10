defmodule Aoc.Day06 do
  import Aoc.Utils

  @spec part1(String.t()) :: :ok
  def part1(input) do
    grid =
      input
      |> make_grid()

    move(grid)
    |> Enum.flat_map(& &1)
    |> Enum.count(&(&1 == "X"))
    |> IO.inspect()
  end

  @spec make_grid(String.t()) :: [[String.t()]]
  defp make_grid(input) do
    input
    |> split_by_newline()
    |> Enum.map(&String.graphemes/1)
  end

  @spec move([[String.t()]]) :: [[String.t()]]
  defp move(grid) do
    case find_guard(grid) do
      nil ->
        grid

      {{row, col}, dir} ->
        cond do
          dir == "^" ->
            up(grid, {row, col})
            |> move()

          dir == "v" ->
            down(grid, {row, col})
            |> move()

          dir == "<" ->
            left(grid, {row, col})
            |> move()

          dir == ">" ->
            right(grid, {row, col})
            |> move()
        end
    end
  end

  @spec find_guard([[String.t()]]) :: {{integer(), integer()}, String.t()}
  defp find_guard(grid) do
    Enum.find_value(grid, fn row ->
      case Enum.find_index(row, &(&1 in ["^", ">", "v", "<"])) do
        nil -> nil
        col -> {{Enum.find_index(grid, &(&1 == row)), col}, Enum.at(row, col)}
      end
    end)
  end

  @spec up([[String.t()]], {integer, integer}) :: [[String.t()]]
  defp up(grid, {row, col}) do
    cond do
      row == 0 ->
        List.update_at(grid, row, fn r -> List.update_at(r, col, fn _ -> "X" end) end)

      Enum.at(Enum.at(grid, row - 1), col) == "#" ->
        List.update_at(grid, row, fn r -> List.update_at(r, col, fn _ -> ">" end) end)

      true ->
        grid
        |> List.update_at(row, fn r -> List.update_at(r, col, fn _ -> "X" end) end)
        |> List.update_at(row - 1, fn r -> List.update_at(r, col, fn _ -> "^" end) end)
    end
  end

  @spec down([[String.t()]], {integer, integer}) :: [[String.t()]]
  defp down(grid, {row, col}) do
    cond do
      row == length(grid) - 1 ->
        List.update_at(grid, row, fn r -> List.update_at(r, col, fn _ -> "X" end) end)

      Enum.at(Enum.at(grid, row + 1), col) == "#" ->
        List.update_at(grid, row, fn r -> List.update_at(r, col, fn _ -> "<" end) end)

      true ->
        grid
        |> List.update_at(row, fn r -> List.update_at(r, col, fn _ -> "X" end) end)
        |> List.update_at(row + 1, fn r -> List.update_at(r, col, fn _ -> "v" end) end)
    end
  end

  @spec left([[String.t()]], {integer, integer}) :: [[String.t()]]
  defp left(grid, {row, col}) do
    cond do
      col == 0 ->
        List.update_at(grid, row, fn r -> List.update_at(r, col, fn _ -> "X" end) end)

      Enum.at(Enum.at(grid, row), col - 1) == "#" ->
        List.update_at(grid, row, fn r -> List.update_at(r, col, fn _ -> "^" end) end)

      true ->
        grid
        |> List.update_at(row, fn r -> List.update_at(r, col, fn _ -> "X" end) end)
        |> List.update_at(row, fn r -> List.update_at(r, col - 1, fn _ -> "<" end) end)
    end
  end

  @spec right([[String.t()]], {integer, integer}) :: [[String.t()]]
  defp right(grid, {row, col}) do
    cond do
      col == length(Enum.at(grid, row)) - 1 ->
        List.update_at(grid, row, fn r -> List.update_at(r, col, fn _ -> "X" end) end)

      Enum.at(Enum.at(grid, row), col + 1) == "#" ->
        List.update_at(grid, row, fn r -> List.update_at(r, col, fn _ -> "v" end) end)

      true ->
        grid
        |> List.update_at(row, fn r -> List.update_at(r, col, fn _ -> "X" end) end)
        |> List.update_at(row, fn r -> List.update_at(r, col + 1, fn _ -> ">" end) end)
    end
  end
end
