require_relative 'tape'
require_relative 'instructions'

class Interpreter

  def initialize(output)
    @output = output
  end

  def interpret(instructions)
    tape_controller = TapeController.new(Tape.new, 0)
    instructions_iterator = InstructionsIterator.new(instructions)
    instruction_index = 0

    while instructions_iterator.has_next?
      instruction = instructions_iterator.next
      instruction_index += 1

      if instruction == :move_right
        tape_controller.move_right
      elsif instruction == :move_left
        tape_controller.move_left
      elsif instruction == :increment_value
        tape_controller.increment_value
      elsif instruction == :decrement_value
        tape_controller.decrement_value
      elsif instruction == :output
        @output.print tape_controller.read.chr
      elsif instruction == :input
        #puts "Only numeric input supported: "
        #tape[pointer] = gets.to_i
      elsif instruction == :jump_past
        if tape_controller.at_zero_cell?
          stack = 1
          while stack > 0
            nested_instruction = instructions[instruction_index]
            if nested_instruction == :jump_past
              stack += 1
            elsif nested_instruction == :jump_back
              stack -= 1
            end
            instruction_index += 1
            instructions_iterator.current_instruction_index += 1
          end
        end
      elsif instruction == :jump_back
        if !tape_controller.at_zero_cell?
          instruction_index -= 2
          instructions_iterator.current_instruction_index -= 2
          stack = 1
          while stack > 0
            nested_instruction = instructions[instruction_index]
            if nested_instruction == :jump_back
              stack += 1
            elsif nested_instruction == :jump_past
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
