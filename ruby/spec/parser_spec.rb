require_relative '../src/parser'

RSpec.describe Parser, '#parse' do
  let(:parser) { Parser.new }
  
  it 'parse source containing only available commands' do
    source = '[><+-.,]'

    expect(parser.parse(source)).to eq [
      :jump_past, :move_right, :move_left, :increment_value,
      :decrement_value, :output, :input, :jump_back
    ]
  end

end
