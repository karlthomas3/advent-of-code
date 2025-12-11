defmodule Aoc.Utils do
  def split_by_line(input) do
    input
    |> String.trim()
    |> String.split("\n", trim: true)
  end

  @spec make_grid([String.t()]) :: map()
  def make_grid(list) do
    for {line, y} <- Enum.with_index(list),
        {char, x} <- String.graphemes(line) |> Enum.with_index(),
        into: %{},
        do: {{x, y}, char}
  end
end
