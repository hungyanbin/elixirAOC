defmodule Aoc_daytwo do
  #state: op, intcode, index
  def compile(int_code, _, opcode) when opcode == 99 do
    int_code
  end

  #Add
  def compile(int_code, index, opcode) when opcode == 1 do
    first_index = Enum.at(int_code, index + 1)
    first_number = Enum.at(int_code, first_index)
    second_index = Enum.at(int_code, index + 2)
    second_number = Enum.at(int_code, second_index)

    result_index = Enum.at(int_code, index + 3)
    new_int_code = List.replace_at(int_code, result_index, first_number + second_number)
    compile(new_int_code, index + 4, Enum.at(new_int_code, index + 4))
  end

  #multiply
  def compile(int_code, index, opcode) when opcode == 2 do
    first_index = Enum.at(int_code, index + 1)
    first_number = Enum.at(int_code, first_index)
    second_index = Enum.at(int_code, index + 2)
    second_number = Enum.at(int_code, second_index)

    result_index = Enum.at(int_code, index + 3)
    new_int_code = List.replace_at(int_code, result_index, first_number * second_number)
    compile(new_int_code, index + 4, Enum.at(new_int_code, index + 4))
  end

  def part_two(int_code, noun, verb) when verb == 100 do
    IO.puts("#{noun}, #{verb}")
    part_two(int_code, noun + 1, 0)
  end

  def part_two(int_code, noun, verb) when verb < 100 do
    IO.puts("#{noun}, #{verb}")
    candidate = int_code |> List.replace_at(1, noun) |> List.replace_at(2, verb)
    result = compile(candidate, 0, Enum.at(candidate, 0))
    output = result |> Enum.at(0)

    if output == 19690720 do
      noun * 100 + verb
    else
      part_two(int_code, noun, verb + 1)
    end
  end

end

input = [1,12,2,3,1,1,2,3,1,3,4,3,1,5,0,3,2,9,1,19,1,19,6,23,2,6,23,27,2,27,9,31,1,5,31,35,1,35,10,39,2,39,9,43,1,5,43,47,2,47,10,51,1,51,6,55,1,5,55,59,2,6,59,63,2,63,6,67,1,5,67,71,1,71,9,75,2,75,10,79,1,79,5,83,1,10,83,87,1,5,87,91,2,13,91,95,1,95,10,99,2,99,13,103,1,103,5,107,1,107,13,111,2,111,9,115,1,6,115,119,2,119,6,123,1,123,6,127,1,127,9,131,1,6,131,135,1,135,2,139,1,139,10,0,99,2,0,14,0]
IO.inspect(Aoc_daytwo.part_two(input, 0, 0))
