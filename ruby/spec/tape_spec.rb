require_relative '../src/tape'

RSpec.describe Tape do
  let(:tape) { Tape.new }

  describe '#at' do
    it 'returns 0 when no value at index' do
      expect(tape.at(0)).to eq 0
      expect(tape.at(100000)).to eq 0
    end
  end

  describe '#update' do
    it 'updates value at index not yet used' do
      tape.update(5120) { |value| value + 13 }

      expect(tape.at(5120)).to eq 13
    end

    it 'updates existing value at index' do
      tape.update(10) { |value| value + 21 }
      tape.update(10) { |value| value - 13 }
 
      expect(tape.at(10)).to eq 8
    end
  end

  describe '#blank_at?' do
    it 'is blank if no value at index' do
      expect(tape.blank_at?(0)).to be true
      expect(tape.blank_at?(100000)).to be true
    end

    it 'is blank if value at index is 0' do
      tape.update(10) { |value| value + 1 }
      tape.update(10) { |value| value - 1 }

      expect(tape.blank_at?(10)).to be true
    end

    it 'is not blank if a non 0 value at index' do
      tape.update(10) { |value| value + 14 }

      expect(tape.blank_at?(10)).to be false
    end
  end
end

RSpec.describe TapeController do
  let(:tape) do
    tape = Tape.new
    0.upto(10) { |i| tape.update(i) { i + 1 } }
    return tape
  end
  let(:controller) { TapeController.new(tape, 0) }
  
  describe '#read' do
    it 'reads current pointer of the cell' do
      controller = TapeController.new(tape, 2)

      expect(controller.read).to eq 3
    end
  end
end
