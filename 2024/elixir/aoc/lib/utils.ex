defmodule Aoc.Utils do
  @spec split_by_newline(String.t()) :: [String.t()]
  def split_by_newline(input) do
    input
    |> String.split("\n", trim: true)
  end

  @spec split_into_grid(String.t(), boolean()) :: [[String.t() | integer()]]
  def split_into_grid(input, numbers \\ false) do
    grid =
      input
      |> String.trim()
      |> split_by_newline()
      |> Enum.map(&String.split(&1, "", trim: true))

    if numbers == true do
      grid
      |> Enum.map(fn row -> Enum.map(row, &String.to_integer/1) end)
    else
      grid
    end
  end

  @spec value_from_grid_pos([[integer() | String.t()]], {integer(), integer()}) ::
          String.t() | integer()
  def value_from_grid_pos(grid, {x, y}) do
    Enum.at(Enum.at(grid, x), y)
  end
end
