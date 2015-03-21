class Memory

  def initialize()
    @raw = []
  end

  def at(pointer)
    @raw[pointer] || 0
  end

  def update(pointer, &update_block)
    current_value = at(pointer)
    @raw[pointer] = update_block.call(current_value)
  end

end
