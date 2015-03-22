require_relative '../src/instructions'

RSpec.describe InstructionsIterator do
  let(:iterator) do 
    iterator_for([:jump_past, :move_right, :move_left,
                  :increment_value, :decrement_value, :jump_back])
  end

  describe '#has_next?' do
    it 'has next instruction when not at end' do
      expect(iterator.has_next?).to be true
    end

    it 'doesnt have next instruction when at end' do
      10.times { iterator.next }

      expect(iterator.has_next?).to be false
    end
  end

  describe '#next' do
    it 'returns next instructions' do
      expect(iterator.next).to eq :jump_past
      expect(iterator.next).to eq :move_right
      expect(iterator.next).to eq :move_left
      expect(iterator.next).to eq :increment_value
      expect(iterator.next).to eq :decrement_value
      expect(iterator.next).to eq :jump_back
    end

    it 'returns nil if no more instructions' do
      6.times { iterator.next }
      
      expect(iterator.next).to be nil
    end
  end

  describe '#previous' do
    it 'returns previous instructions' do
      6.times { iterator.next }

      expect(iterator.previous).to eq :jump_back
      expect(iterator.previous).to eq :decrement_value
      expect(iterator.previous).to eq :increment_value
      expect(iterator.previous).to eq :move_left
      expect(iterator.previous).to eq :move_right
      expect(iterator.previous).to eq :jump_past
    end

    it 'returns nil if no more instructions' do
      expect(iterator.previous).to be nil
    end
  end

  describe '#jump_past_matching_loop' do
    it 'jumps to instruction after closing of loop' do
      iterator = iterator_for([:output, :output, :jump_back, :ok, :input])

      iterator.jump_past_matching_loop

      expect(iterator.next).to be :ok
    end

    it 'jumps to end of instructions' do
      iterator = iterator_for([:output, :output, :jump_back])

      iterator.jump_past_matching_loop

      expect(iterator.next).to be nil
    end

    it 'jumps ignoring nested loops' do
      iterator = iterator_for([:output, :jump_past, :output, :jump_back, 
                               :jump_back, :ok, :input])

      iterator.jump_past_matching_loop

      expect(iterator.next).to be :ok
    end
  end

  describe '#jump_back' do
    it 'jumps to start of loop' do
      iterator = iterator_for([:jump_past, :ok, :output, :output, :jump_back])
      5.times { iterator.next }

      iterator.jump_back
      iterator.next

      expect(iterator.next).to be :ok
    end

    it 'jumps ignore nested loops' do
      iterator = iterator_for([:jump_past, :ok, :jump_past, :output, :jump_back, :jump_back])
      6.times { iterator.next }

      iterator.jump_back
      iterator.next

      expect(iterator.next).to be :ok
    end    
  end

  def iterator_for(instructions)
    InstructionsIterator.new(instructions)
  end
end
