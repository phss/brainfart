require_relative 'tape'

class Interpreter

  def initialize(output)
    @output = output
  end

  def interpret(code)
    tape = Tape.new
    pointer = 0
    operation_index = 0

    while operation_index <= code.size
      operation = code[operation_index]
      operation_index += 1

      if operation == '>'
        pointer += 1
      elsif operation == '<'
        pointer -= 1
      elsif operation == '+'
        tape.update(pointer) { |value| value + 1 }
      elsif operation == '-'
        tape.update(pointer) { |value| value - 1 }
      elsif operation == '.'
        @output.print tape.at(pointer).chr
      elsif operation == ','
        #puts "Only numeric input supported: "
        #tape[pointer] = gets.to_i
      elsif operation == '['
        if tape.blank_at?(pointer)
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
        if !tape.blank_at?(pointer)
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
