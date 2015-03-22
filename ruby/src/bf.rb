require_relative 'interpreter'
require_relative 'parser'

filename = ARGV.shift
code = File.read(filename)
instructions = Parser.new.parse(code)

interpreter = Interpreter.new($stdout)

interpreter.interpret(instructions)
