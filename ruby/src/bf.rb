require 'yaml'
require_relative 'interpreter'
require_relative 'parser'
require_relative 'io'


def parse_input
  source_config = YAML.load_file(ARGV.shift)
  source = File.read(ARGV.shift)
  return Parser.new(source_config).parse(source)
end

def interpret(instructions)
  io = IOUtil.new($stdin, $stdout)
  interpreter = Interpreter.new(io)
  interpreter.interpret(instructions)
end


instructions = parse_input
interpret(instructions)
