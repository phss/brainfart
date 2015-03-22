class IOUtil

  def initialize(input, output)
    @input = input
    @output = output
  end

  def print_char(int_value)
    @output.print(int_value.chr)
  end

  def read_int
    @output.puts("Only numeric values acccepted. No validation performed.")
    @input.gets.to_i
  end

end
