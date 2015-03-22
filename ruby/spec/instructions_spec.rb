require_relative '../src/instructions'

RSpec.describe InstructionsIterator do
  let(:instructions) { 'abcdef' }
  let(:iterator) { InstructionsIterator.new(instructions, 0) }

  describe '#has_next?' do
    it 'has next instruction when not at end' do
      expect(iterator.has_next?).to be true
    end

    it 'doesnt have next instruction when at end' do
      iterator = InstructionsIterator.new(instructions, instructions.size - 1)

      expect(iterator.has_next?).to be false
    end
  end

  describe '#next' do
    it 'returns next iterations' do
      expect(iterator.next).to eq 'a'
      expect(iterator.next).to eq 'b'
      expect(iterator.next).to eq 'c'
    end
  end
end
