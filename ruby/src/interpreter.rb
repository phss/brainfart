class Interpreter

  def initialize(output)
    @output = output
  end

  def interpret(code)
    @output.print "Hello world!"
  end
  
end
