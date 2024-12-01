defmodule Aoc.Utils do
  def split_by_newline(input) do
    input
    |> String.split("\n", trim: true)
  end
end
