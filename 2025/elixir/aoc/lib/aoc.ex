defmodule Aoc do
  def hello, do: :world

  def solve(day, part) do
    input = File.read!(input_file(day))

    module =
      String.to_existing_atom("Elixir.Aoc.Day#{String.pad_leading("#{day}", 2, "0")}")

    apply(module, String.to_atom("part#{part}"), [input])
  end

  defp input_file(day) do
    day_str = String.pad_leading("#{day}", 2, "0")

    Path.join([
      "..",
      "..",
      "inputs",
      "2025_#{day_str}.txt"
    ])
  end
end
