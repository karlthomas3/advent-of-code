defmodule Aoc.Day09 do
  @spec part1(String.t()) :: :ok
  def part1(input) do
    # test = "2333133121414131402"

    input
    |> String.trim()
    |> String.graphemes()
    |> convert()
    |> swap_numbers_dots()
    |> checksum()
    |> IO.puts()
  end

  @spec convert([String.t()]) :: [String.t()]
  defp convert(string_list) do
    convert(string_list, 0, [])
  end

  @spec convert([String.t()]) :: [String.t()]
  defp convert([], _id, out_list), do: out_list

  @spec convert([String.t()], integer(), [String.t()]) :: [String.t()]
  defp convert([h1], id, out_list) do
    id_str = Integer.to_string(id)
    repeated_list = List.duplicate(id_str, String.to_integer(h1))
    out_list ++ repeated_list
  end

  @spec convert([String.t()], integer(), [String.t()]) :: [String.t()]
  defp convert([h1, h2 | t], id, out_list) do
    id_str = Integer.to_string(id)
    block = List.duplicate(id_str, String.to_integer(h1))
    free_space = List.duplicate(".", String.to_integer(h2))

    new_list = block ++ free_space
    new_out = out_list ++ new_list

    convert(t, id + 1, new_out)
  end

  @spec swap_numbers_dots([String.t()]) :: [String.t()]
  defp swap_numbers_dots(list) do
    case swap_number_with_dot(list) do
      ^list -> list
      new_list -> swap_numbers_dots(new_list)
    end
  end

  @spec swap_number_with_dot([String.t()]) :: [String.t()]
  defp swap_number_with_dot(list) do
    last_num_index =
      Enum.find_index(
        Enum.reverse(list),
        &(&1 != ".")
      )

    first_dot_index = Enum.find_index(list, &(&1 == "."))

    if last_num_index != nil and first_dot_index != nil and
         first_dot_index < length(list) - 1 - last_num_index do
      last_num_index = length(list) - 1 - last_num_index

      list
      |> List.replace_at(first_dot_index, Enum.at(list, last_num_index))
      |> List.replace_at(last_num_index, ".")
    else
      list
    end
  end

  @spec checksum([String.t()]) :: integer()
  defp checksum(list), do: checksum(list, 0, 0)

  @spec checksum([], integer(), integer()) :: integer()
  defp checksum([], _, acc), do: acc

  @spec checksum([String.t()], integer(), integer()) :: integer()
  defp checksum([h | t], pos, acc) do
    if h == "." do
      checksum(t, pos + 1, acc)
    else
      id = String.to_integer(h)
      num = id * pos
      checksum(t, pos + 1, acc + num)
    end
  end
end
