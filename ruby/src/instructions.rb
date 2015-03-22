class InstructionsIterator

  def initialize(instructions, starting_instruction_index)
    @instructions = instructions
    @current_instruction_index = starting_instruction_index
  end

  def has_next?
    @current_instruction_index < @instructions.size - 1
  end

  def next
    instruction = @instructions[@current_instruction_index]
    @current_instruction_index += 1
    return instruction
  end

end