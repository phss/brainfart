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
end
