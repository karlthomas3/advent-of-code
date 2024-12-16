defmodule Aoc.Utils do
  def split_by_newline(input) do
    input
    |> String.split("\n", trim: true)
  end

  def split_into_grid(input) do
    input
    |> split_by_newline()
    |> Enum.map(&String.split(&1, "", trim: true))
  end
end
