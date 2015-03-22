class Parser

  def initialize
    @bf_to_instruction = {
      '>' => :move_right,
      '<' => :move_left,
      '+' => :increment_value,
      '-' => :decrement_value,
      '.' => :output,
      ',' => :input,
      '[' => :jump_past,
      ']' => :jump_back
    }
  end

  def parse(source)
    source.split('').map { |command| @bf_to_instruction[command] }.compact
  end
  
end
