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
    source.split('').map do |bf_command|
      @bf_to_instruction[bf_command]
    end
  end
  
end
