require_relative 'interpreter'
require_relative 'parser'


def parse_input
  filename = ARGV.shift
  code = File.read(filename)
  return Parser.new.parse(code)
end

def interpret(instructions)
  interpreter = Interpreter.new($stdout)
  interpreter.interpret(instructions)
end


instructions = parse_input
interpret(instructions)
