require_relative '../src/parser'

RSpec.describe Parser, '#parse' do
  let(:parser) { Parser.new }
  
  it 'parse source containing all available commands' do
    source = '[><+-.,]'

    expect(parser.parse(source)).to eq [
      :jump_past, :move_right, :move_left, :increment_value,
      :decrement_value, :output, :input, :jump_back
    ]
  end

  it 'ignores non-bf characters' do
    source = '[abc+.#blah]'

    expect(parser.parse(source)).to eq [
      :jump_past, :increment_value, :output, :jump_back
    ]
  end
end
