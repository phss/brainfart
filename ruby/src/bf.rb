require_relative 'interpreter'
require_relative 'parser'
require_relative 'io'


def parse_input
  filename = ARGV.shift
  code = File.read(filename)
  return Parser.new.parse(code)
end

def interpret(instructions)
  io = IOUtil.new($stdout)
  interpreter = Interpreter.new(io)
  interpreter.interpret(instructions)
end


instructions = parse_input
interpret(instructions)
