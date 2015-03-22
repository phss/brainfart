require_relative '../src/parser'

RSpec.describe Parser, '#parse' do
  let(:simple_language) do
    {
      "command_size" => 1,
      "commands"=> {
        "cmdA" => "a",
        "cmdB" => "b",
        "cmdC" => "c"
      }
    }
  end
  let(:parser) { Parser.new(simple_language) }

  it 'parse source containing all available commands' do
    source = 'bac'

    expect(parser.parse(source)).to eq [:cmdB, :cmdA, :cmdC]
  end

  it 'ignores non-bf characters' do
    source = '[bXc+.#blahCCC]'

    expect(parser.parse(source)).to eq [:cmdB, :cmdC, :cmdB, :cmdA]
  end
end
