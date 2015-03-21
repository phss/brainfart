require_relative '../src/memory'

RSpec.describe Memory do
  let(:memory) { Memory.new }

  describe '#at' do
    it 'returns 0 when no value at pointer' do
      expect(memory.at(0)).to eq 0
      expect(memory.at(100000)).to eq 0
    end
  end

  describe '#update' do
    it 'updates value at pointer not yet used' do
      memory.update(5120) { |value| value + 13 }

      expect(memory.at(5120)).to eq 13
    end

    it 'updates existing value at pointer' do
      memory.update(10) { |value| value + 21 }
      memory.update(10) { |value| value - 13 }
      
      expect(memory.at(10)).to eq 8
    end
  end

  describe '#blank_at?' do
    it 'is blank if no value at pointer' do
      expect(memory.blank_at?(0)).to be true
      expect(memory.blank_at?(100000)).to be true
    end

    it 'is blank if value at pointer is 0' do
      memory.update(10) { |value| value + 1 }
      memory.update(10) { |value| value - 1 }

      expect(memory.blank_at?(10)).to be true
    end

    it 'is not blank if a non 0 value at pointer' do
      memory.update(10) { |value| value + 14 }

      expect(memory.blank_at?(10)).to be false
    end
  end
end
