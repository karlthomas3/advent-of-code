defmodule Aoc.Utils do
  def split_by_line(input) do
    input
    |> String.trim()
    |> String.split("\n", trim: true)
  end
end
