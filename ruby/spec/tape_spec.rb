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
    0.upto(10) { |i| tape.update(i) { i } }
    return tape
  end
  let(:controller) { TapeController.new(tape, 3) }
  
  describe '(reading)' do
    it 'reads current pointer of the cell' do
      expect(controller.read).to eq 3
    end

    it 'is not at zero cell if tape has non zero value' do
      expect(controller.at_zero_cell?).to be false
    end

    it 'is at zero cell if tape has 0' do
      controller = TapeController.new(tape, 0)

      expect(controller.at_zero_cell?).to be true
    end

    it 'is at zero cell if in new tape space' do
      controller = TapeController.new(tape, 1000)

      expect(controller.at_zero_cell?).to be true
    end
  end

  describe '(moving pointer)' do
    it 'moves pointer left' do
      controller.move_left

      expect(controller.read).to eq 2
    end

    it 'moves pointer right' do
      controller.move_right

      expect(controller.read).to eq 4
    end
  end
end
