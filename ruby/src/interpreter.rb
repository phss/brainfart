require_relative 'tape'
require_relative 'instructions'

class Interpreter

  def initialize(output)
    @output = output
  end

  def interpret(instructions)
    tape_controller = TapeController.new(Tape.new, 0)
    instructions_iterator = InstructionsIterator.new(instructions)
    rules = interpretation_rules(tape_controller, instructions_iterator)

    while instructions_iterator.has_next?
      instruction = instructions_iterator.next
      rules[instruction].call
    end
  end

 private 

  def interpretation_rules(tape_controller, instructions_iterator)
    {
      move_right:  lambda { tape_controller.move_right },
      move_left:  lambda { tape_controller.move_left },
      increment_value: lambda { tape_controller.increment_value },
      decrement_value: lambda { tape_controller.decrement_value },
      output: lambda { @output.print tape_controller.read.chr },
      input: lambda { },
      jump_past: lambda { instructions_iterator.jump_past_matching_loop if tape_controller.at_zero_cell? },
      jump_back: lambda { instructions_iterator.jump_back_loop_start unless tape_controller.at_zero_cell? },
    }
  end

end
