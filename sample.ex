defmodule Sort do
  def insertion(input_list, start_index) do
    min_pair = min(input_list, start_index, 0, 0)
    swap_value = Enum.at(input_list, start_index)

    l1 = List.replace_at(input_list, start_index, min_pair[:value])
    l2 = List.replace_at(l1, min_pair[:index], swap_value)

    if start_index < length(input_list) do
      insert(l2, start_index + 1)
    else
      l2
    end
  end

  defp min(input_list, index, min_number, min_index) do
    length = length(input_list)
    min_pair = if min_number == 0 do
      [value: Enum.at(input_list, index), index: index]
    else
      candidate = Enum.at(input_list, index)

      if candidate < min_number do
        [value: candidate, index: index]
      else
        [value: min_number, index: min_index]
      end

    end

    if index < length do
      min(input_list, index + 1, min_pair[:value], min_pair[:index])
    else
      min_pair
    end
  end

  def quick(list) do
    if length(list) <= 1 do
      list
    else
      mid = Enum.at(list, 0)
      remain = Enum.slice(list, 1, length(list))
      small_list = remain |> Enum.filter(fn (x) -> x <= mid end)
      large_list = remain |> Enum.filter(fn (x) -> x > mid end)

      quick(small_list) |> Enum.concat([mid]) |> Enum.concat(quick(large_list))
    end
  end

end

test = [5, 3, 6, 2, 28, 99, 43, 34]
result = Sort.quick(test)
IO.inspect(result, label: "Sort result")
