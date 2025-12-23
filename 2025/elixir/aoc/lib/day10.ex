defmodule Aoc.Day10 do
  import Aoc.Utils

  @test_input "[.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7}\n[...#.] (0,2,3,4) (2,3) (0,4) (0,1,2) (1,2,3,4) {7,5,12,7,2}\n[.###.#] (0,1,2,3,4) (0,3,4) (0,1,2,4,5) (1,2) {10,11,11,5,10,5}"

  @spec part1(String.t()) :: integer()
  def part1(input) do
    input
    |> split_by_line()
    |> Enum.map(&parse_line/1)
    |> Enum.map(fn {lights, buttons, _joltage} ->
      case bfs_shortest_light(buttons, lights) do
        {:ok, seq} -> length(seq)
        :no_solution -> -1
      end
    end)
    |> Enum.sum()
  end

  @spec part2(String.t()) :: integer()
  def part2(input) do
    input
    |> split_by_line()
    |> Enum.map(&parse_line/1)
    |> Enum.map(fn {_lights, buttons, joltage} ->
      case bfs_shortest_joltage_count(buttons, joltage) do
        {:ok, steps} -> steps
        :no_solution -> -1
      end
    end)
    |> Enum.sum()
  end

  defp parse_line(line) do
    parts = String.split(line, " ")
    lights = hd(parts) |> parse_lights()
    buttons = parse_buttons(parts)
    joltage = parse_joltage(parts)
    {lights, buttons, joltage}
  end

  defp parse_lights(str) do
    str
    |> String.replace(["[", "]"], "")
    |> String.graphemes()
    |> Enum.map(&(&1 == "#"))
    |> List.to_tuple()
  end

  defp parse_buttons(lst) do
    lst
    |> Enum.filter(&String.starts_with?(&1, "("))
    |> Enum.map(fn btn ->
      btn
      |> String.replace(["(", ")"], "")
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
    end)
  end

  defp parse_joltage(lst) do
    lst
    |> Enum.filter(&String.starts_with?(&1, "{"))
    |> Enum.map(fn joltage ->
      joltage
      |> String.replace(["{", "}"], "")
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
    end)
    |> hd()
    |> List.to_tuple()
  end

  defp press_light_button(state_tuple, btn) do
    Enum.reduce(btn, state_tuple, fn idx, acc ->
      put_elem(acc, idx, not elem(acc, idx))
    end)
  end

  defp initial_light(len), do: List.to_tuple(Enum.map(1..len, fn _ -> false end))

  defp initial_joltage(len), do: List.to_tuple(Enum.map(1..len, fn _ -> 0 end))

  defp bfs_shortest_light(buttons, target_tuple) do
    initial = initial_light(tuple_size(target_tuple))

    if initial == target_tuple do
      {:ok, []}
    else
      bfs_loop(
        :queue.from_list([initial]),
        MapSet.new([initial]),
        %{initial => nil},
        %{},
        buttons,
        target_tuple
      )
    end
  end

  defp bfs_loop(queue, visited, parents, labels, buttons, target) do
    case :queue.out(queue) do
      {:empty, _} ->
        :no_solution

      {{:value, state}, qrest} ->
        {q2, vis2, par2, lab2, found} =
          Enum.reduce_while(
            Enum.with_index(buttons),
            {qrest, visited, parents, labels, nil},
            fn {btn, bi}, {q_acc, vis_acc, par_acc, lab_acc, _} ->
              next = press_light_button(state, btn)

              if MapSet.member?(vis_acc, next) do
                {:cont, {q_acc, vis_acc, par_acc, lab_acc, nil}}
              else
                par_acc = Map.put(par_acc, next, state)
                lab_acc = Map.put(lab_acc, next, bi)

                if next == target do
                  seq = reconstruct_sequence(par_acc, lab_acc, next)
                  {:halt, {q_acc, vis_acc, par_acc, lab_acc, {:found, seq}}}
                else
                  {:cont,
                   {:queue.in(next, q_acc), MapSet.put(vis_acc, next), par_acc, lab_acc, nil}}
                end
              end
            end
          )

        case found do
          {:found, seq} -> {:ok, seq}
          _ -> bfs_loop(q2, vis2, par2, lab2, buttons, target)
        end
    end
  end

  defp reconstruct_sequence(parents, labels, target) do
    do_reconstruct(target, parents, labels, []) |> Enum.reverse()
  end

  defp do_reconstruct(state, parents, labels, acc) do
    case Map.get(parents, state) do
      nil -> acc
      prev -> do_reconstruct(prev, parents, labels, [Map.fetch!(labels, state) | acc])
    end
  end

  defp press_joltage_button(state, btn, target_state) do
    Enum.reduce_while(btn, state, fn idx, acc ->
      cur = elem(acc, idx)
      maxv = elem(target_state, idx)

      if cur + 1 > maxv do
        {:halt, :invalid}
      else
        {:cont, put_elem(acc, idx, cur + 1)}
      end
    end)
    |> case do
      :invalid -> nil
      new_state -> new_state
    end
  end

  defp bfs_shortest_joltage_count(buttons, target) do
    initial = initial_joltage(tuple_size(target))

    if initial == target do
      {:ok, 0}
    else
      bfs_joltage_loop_count(
        :queue.from_list([{initial, 0}]),
        MapSet.new([initial]),
        buttons,
        target,
        0
      )
    end
  end

  defp bfs_joltage_loop_count(queue, visited, buttons, target, steps) do
    if rem(steps, 100_000) == 0 do
      IO.puts(
        "bfs (joltage) steps=#{steps} queue=#{:queue.len(queue)} visited=#{MapSet.size(visited)}"
      )
    end

    case :queue.out(queue) do
      {:empty, _} ->
        :no_solution

      {{:value, {state, dist}}, qrest} ->
        {q2, vis2, found} =
          Enum.reduce_while(Enum.with_index(buttons), {qrest, visited, nil}, fn {btn, _bi},
                                                                                {q_acc, vis_acc,
                                                                                 _} ->
            case press_joltage_button(state, btn, target) do
              nil ->
                {:cont, {q_acc, vis_acc, nil}}

              next ->
                if MapSet.member?(vis_acc, next) do
                  {:cont, {q_acc, vis_acc, nil}}
                else
                  if next == target do
                    {:halt, {q_acc, vis_acc, {:found, dist + 1}}}
                  else
                    {:cont, {:queue.in({next, dist + 1}, q_acc), MapSet.put(vis_acc, next), nil}}
                  end
                end
            end
          end)

        case found do
          {:found, s} -> {:ok, s}
          _ -> bfs_joltage_loop_count(q2, vis2, buttons, target, steps + 1)
        end
    end
  end
end
