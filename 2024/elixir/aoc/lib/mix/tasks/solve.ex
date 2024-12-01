defmodule Mix.Tasks.Aoc.Solve do
  use Mix.Task

  def run(args) do
    [day, part] = args
    # IO.puts()

    Aoc.solve(
      String.to_integer(day),
      String.to_integer(part)
    )
  end
end
