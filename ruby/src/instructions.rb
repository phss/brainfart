class InstructionsIterator

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

end
