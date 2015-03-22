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

  def previous
    return nil if @current_instruction_index < 0

    previous_instruction = @instructions[@current_instruction_index]
    @current_instruction_index -= 1
    return previous_instruction
  end

  def jump_past_matching_loop
    jump(:jump_past, :jump_back, &method(:next))
  end

  def jump_back_loop_start
    previous
    jump(:jump_back, :jump_past, &method(:previous))
  end

 private

  def jump(push_instruction, pop_instruction, &next_function)
    stack = 1
    while stack > 0
      nested_instruction = next_function.call
      if nested_instruction == push_instruction
        stack += 1
      elsif nested_instruction == pop_instruction
        stack -= 1
      elsif nested_instruction.nil?
        raise "No matching loop"
      end
    end
  end

end
