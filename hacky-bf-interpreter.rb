
def interpret(code)
  memory = Array.new(100, 0)
  pointer = 0

  code.each_char do |operation|
    if operation == '>'
      pointer += 1
    end
  end

  puts pointer
end


filename = ARGV.shift
code = File.read(filename)
interpret(code)
