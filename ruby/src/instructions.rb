class InstructionsIterator

  def initialize(instructions)
    @instructions = instructions
    @current_instruction_index = 0
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
