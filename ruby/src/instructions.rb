class InstructionsIterator
  attr_accessor :current_instruction_index

  def initialize(instructions)
    @instructions = instructions
    @current_instruction_index = -1
  end

  def has_next?
    @current_instruction_index < @instructions.size - 1
  end

  def next
    return nil unless has_next?

    @instructions[@current_instruction_index += 1]
  end

  def previous
    return nil if @current_instruction_index < 0

    i = @instructions[@current_instruction_index]
    @current_instruction_index -= 1
    i
  end

  def jump_past_matching_loop
    stack = 1
    while stack > 0
      nested_instruction = self.next
      if nested_instruction == :jump_past
        stack += 1
      elsif nested_instruction == :jump_back
        stack -= 1
      end
    end
  end

  def jump_back
    instruction_index -= 2
    instructions_iterator.current_instruction_index -= 2
    stack = 1
    while stack > 0
      nested_instruction = instructions[instruction_index]
      if nested_instruction == :jump_back
        stack += 1
      elsif nested_instruction == :jump_past
        stack -= 1
      end
      instruction_index -= 1
      instructions_iterator.current_instruction_index -= 1
    end
    instruction_index += 1
    instructions_iterator.current_instruction_index += 1
  end

end
