require_relative 'tape'
require_relative 'instructions'

class Interpreter

  def initialize(output)
    @output = output
  end

  def interpret(code)
    tape_controller = TapeController.new(Tape.new, 0)
    instructions_iterator = InstructionsIterator.new(code)
    operation_index = 0

    while instructions_iterator.has_next?
      operation = instructions_iterator.next
      operation_index += 1

      if operation == '>'
        tape_controller.move_right
      elsif operation == '<'
        tape_controller.move_left
      elsif operation == '+'
        tape_controller.increment_value
      elsif operation == '-'
        tape_controller.decrement_value
      elsif operation == '.'
        @output.print tape_controller.read.chr
      elsif operation == ','
        #puts "Only numeric input supported: "
        #tape[pointer] = gets.to_i
      elsif operation == '['
        if tape_controller.at_zero_cell?
          stack = 1
          while stack > 0
            nested_operation = code[operation_index]
            if nested_operation == '['
              stack += 1
            elsif nested_operation == ']'
              stack -= 1
            end
            operation_index += 1
            instructions_iterator.current_instruction_index += 1
          end
        end
      elsif operation == ']'
        if !tape_controller.at_zero_cell?
          operation_index -= 2
          instructions_iterator.current_instruction_index -= 2
          stack = 1
          while stack > 0
            nested_operation = code[operation_index]
            if nested_operation == ']'
              stack += 1
            elsif nested_operation == '['
              stack -= 1
            end
            operation_index -= 1
            instructions_iterator.current_instruction_index -= 1
          end
          operation_index += 1
          instructions_iterator.current_instruction_index += 1
        end
      end
    end
  end

end
