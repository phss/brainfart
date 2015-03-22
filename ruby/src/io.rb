class IOUtil

  def initialize(output)
    @output = output
  end

  def print_char(int_value)
    @output.print(int_value.chr)
  end

end
