class Tape

  def initialize()
    @raw = []
  end

  def at(index)
    @raw[index] || 0
  end

  def blank_at?(index)
    at(index).zero?
  end

  def update(index, &update_block)
    current_value = at(index)
    @raw[index] = update_block.call(current_value)
  end

end

class TapeController

  def initialize(tape, starting_position)
    @tape = tape
    @pointer = starting_position
  end

  def read
    @tape.at(@pointer)
  end

  def at_zero_cell?
    @tape.blank_at?(@pointer)
  end

  def move_left
    @pointer -= 1
  end

  def move_right
    @pointer += 1
  end
end
