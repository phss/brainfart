require_relative 'tape'
require_relative 'instructions'

class Interpreter

  def initialize(io)
    @io = io
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

  def interpretation_rules(tape_controller, iterator)
    {
      move_right:      -> { tape_controller.move_right },
      move_left:       -> { tape_controller.move_left },
      increment_value: -> { tape_controller.increment_value },
      decrement_value: -> { tape_controller.decrement_value },
      output:          -> { @io.print_char(tape_controller.read) },
      input:           -> { tape_controller.store(@io.read_int) },
      jump_past:       -> { iterator.jump_past_matching_loop if tape_controller.at_zero_cell? },
      jump_back:       -> { iterator.jump_back_loop_start if !tape_controller.at_zero_cell? }
    }
  end

end
