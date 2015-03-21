
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
      puts memory[pointer]
    elsif operation == ','
      # Ignore input operation
    elsif operation == '['
      # begin loop
    elsif operation == ']'
      # end loop
    end
  end
end


filename = ARGV.shift
code = File.read(filename)
interpret(code)
