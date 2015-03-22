require_relative 'tape'
require_relative 'instructions'

class Interpreter

  def initialize(output)
    @output = output
  end

  def interpret(code)
    tape_controller = TapeController.new(Tape.new, 0)
    instructions_iterator = InstructionsIterator.new(code)
    instruction_index = 0

    while instructions_iterator.has_next?
      instruction = instructions_iterator.next
      instruction_index += 1

      if instruction == '>'
        tape_controller.move_right
      elsif instruction == '<'
        tape_controller.move_left
      elsif instruction == '+'
        tape_controller.increment_value
      elsif instruction == '-'
        tape_controller.decrement_value
      elsif instruction == '.'
        @output.print tape_controller.read.chr
      elsif instruction == ','
        #puts "Only numeric input supported: "
        #tape[pointer] = gets.to_i
      elsif instruction == '['
        if tape_controller.at_zero_cell?
          stack = 1
          while stack > 0
            nested_instruction = code[instruction_index]
            if nested_instruction == '['
              stack += 1
            elsif nested_instruction == ']'
              stack -= 1
            end
            instruction_index += 1
            instructions_iterator.current_instruction_index += 1
          end
        end
      elsif instruction == ']'
        if !tape_controller.at_zero_cell?
          instruction_index -= 2
          instructions_iterator.current_instruction_index -= 2
          stack = 1
          while stack > 0
            nested_instruction = code[instruction_index]
            if nested_instruction == ']'
              stack += 1
            elsif nested_instruction == '['
              stack -= 1
            end
            instruction_index -= 1
            instructions_iterator.current_instruction_index -= 1
          end
          instruction_index += 1
          instructions_iterator.current_instruction_index += 1
        end
      end
    end
  end

end
