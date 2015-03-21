
def interpret(code)
  memory = Array.new(100, 0)
  pointer = 0

  code.each_char do |operation|
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
    end
  end
end


filename = ARGV.shift
code = File.read(filename)
interpret(code)
