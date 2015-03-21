require_relative '../src/memory'

RSpec.describe Memory do
  let(:memory) { Memory.new }

  describe '#at' do
    it 'returns 0 when no value at pointer' do
      expect(memory.at(0)).to eq 0
      expect(memory.at(100000)).to eq 0
    end
  end
end
