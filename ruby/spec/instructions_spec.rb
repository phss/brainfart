require_relative '../src/instructions'

RSpec.describe InstructionsIterator do
  let(:instructions) { 'abcdef' }
  let(:iterator) { InstructionsIterator.new(instructions) }

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
      expect(iterator.next).to eq 'a'
      expect(iterator.next).to eq 'b'
      expect(iterator.next).to eq 'c'
      expect(iterator.next).to eq 'd'
      expect(iterator.next).to eq 'e'
      expect(iterator.next).to eq 'f'
    end

    it 'returns nil if no more instructions' do
      6.times { iterator.next }
      
      expect(iterator.next).to be nil
    end
  end
end
