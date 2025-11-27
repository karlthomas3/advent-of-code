defmodule Mix.Tasks.Aoc.Solve do
  use Mix.Task

  def run([day, part]) do
    # IO.puts()

    Aoc.solve(
      String.to_integer(day),
      String.to_integer(part)
    )
  end
end
