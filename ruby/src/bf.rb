require_relative 'interpreter'

filename = ARGV.shift
code = File.read(filename)
interpreter = Interpreter.new($stdout)

interpreter.interpret(code)
