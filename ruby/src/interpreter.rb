require_relative 'tape'

class Interpreter

  def initialize(output)
    @output = output
  end

  def interpret(code)
    tape_controller = TapeController.new(Tape.new, 0)
    operation_index = 0

    while operation_index <= code.size
      operation = code[operation_index]
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
          end
        end
      elsif operation == ']'
        if !tape_controller.at_zero_cell?
          operation_index -= 2
          stack = 1
          while stack > 0
            nested_operation = code[operation_index]
            if nested_operation == ']'
              stack += 1
            elsif nested_operation == '['
              stack -= 1
            end
            operation_index -= 1
          end
          operation_index += 1
        end
      end
    end
  end

end
