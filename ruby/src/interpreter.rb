require_relative 'tape'
require_relative 'instructions'

class Interpreter

  def initialize(output)
    @output = output
  end

  def interpret(instructions)
    tape_controller = TapeController.new(Tape.new, 0)
    instructions_iterator = InstructionsIterator.new(instructions)

    while instructions_iterator.has_next?
      instruction = instructions_iterator.next

      if instruction == :move_right
        tape_controller.move_right
      elsif instruction == :move_left
        tape_controller.move_left
      elsif instruction == :increment_value
        tape_controller.increment_value
      elsif instruction == :decrement_value
        tape_controller.decrement_value
      elsif instruction == :output
        @output.print tape_controller.read.chr
      elsif instruction == :input
        #puts "Only numeric input supported: "
        #tape[pointer] = gets.to_i
      elsif instruction == :jump_past
        if tape_controller.at_zero_cell?
          instructions_iterator.jump_past_matching_loop
        end
      elsif instruction == :jump_back
        if !tape_controller.at_zero_cell?
          instructions_iterator.jump_back
        end
      end
    end
  end

end
