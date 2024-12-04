defmodule Aoc.Day04 do
  import Aoc.Utils

  @spec part1(String.t()) :: :ok
  def part1(input) do
    grid =
      input
      |> split_by_newline()
      |> Enum.map(&String.graphemes/1)

    forward =
      grid
      |> Enum.map(&count_substring_in_row(&1, "XMAS"))
      |> Enum.sum()

    backward =
      grid
      |> Enum.map(&count_substring_in_row(&1, "SAMX"))
      |> Enum.sum()

    columns = grid_to_columns(grid)

    forward_column =
      columns
      |> Enum.map(&count_substring_in_row(&1, "XMAS"))
      |> Enum.sum()

    backward_column =
      columns
      |> Enum.map(&count_substring_in_row(&1, "SAMX"))
      |> Enum.sum()

    diagonals = grid_to_diagonals(grid)

    forward_diagonals =
      diagonals
      |> Enum.map(&count_substring_in_row(&1, "XMAS"))
      |> Enum.sum()

    backward_diagonals =
      diagonals
      |> Enum.map(&count_substring_in_row(&1, "SAMX"))
      |> Enum.sum()

    total =
      forward + backward + forward_column + backward_column + forward_diagonals +
        backward_diagonals

    IO.puts(total)
  end

  @spec count_substring_in_row([String.t()], String.t()) :: integer
  defp count_substring_in_row(row, substring) do
    sub = String.graphemes(substring)

    row
    |> Enum.chunk_every(4, 1, :discard)
    |> Enum.count(&(&1 == sub))
  end

  @spec grid_to_columns([[String.t()]]) :: [[String.t()]]
  defp grid_to_columns(grid) do
    grid
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  @spec grid_to_diagonals([[String.t()]]) :: [[String.t()]]
  defp grid_to_diagonals(grid) do
    rows = length(grid)
    cols = length(List.first(grid))

    top_left_to_bottom_right =
      Enum.reduce(0..(rows + cols - 2), [], fn k, acc ->
        diagonal =
          Enum.reduce(0..k, [], fn i, acc2 ->
            j = k - i

            if i < rows and j < cols do
              [Enum.at(Enum.at(grid, i), j) | acc2]
            else
              acc2
            end
          end)

        [Enum.reverse(diagonal) | acc]
      end)

    top_right_to_bottom_left =
      Enum.reduce(0..(rows + cols - 2), [], fn k, acc ->
        diagonal =
          Enum.reduce(0..k, [], fn i, acc2 ->
            j = k - i

            if i < rows and j < cols do
              [Enum.at(Enum.at(grid, i), cols - j - 1) | acc2]
            else
              acc2
            end
          end)

        [Enum.reverse(diagonal) | acc]
      end)

    top_left_to_bottom_right ++ top_right_to_bottom_left
  end
end
