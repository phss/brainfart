
def interpret(code)
  memory = Array.new(100, 0)
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
      memory[pointer] += 1
    elsif operation == '-'
      memory[pointer] -= 1
    elsif operation == '.'
      print memory[pointer].chr
    elsif operation == ','
      # Ignore input operation
    elsif operation == '['
      if memory[pointer] == 0
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
      if memory[pointer] != 0
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


filename = ARGV.shift
code = File.read(filename)
interpret(code)
