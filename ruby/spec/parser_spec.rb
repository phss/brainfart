require_relative '../src/parser'

RSpec.describe Parser, '#parse' do
  context 'one char language' do
    let(:language) do
      {
        "command_size" => 1,
        "commands"=> {
          "cmdA" => "a",
          "cmdB" => "b",
          "cmdC" => "c"
        }
      }
    end
    let(:parser) { Parser.new(language) }

    it 'parse source containing all available commands' do
      source = 'bac'

      expect(parser.parse(source)).to eq [:cmdB, :cmdA, :cmdC]
    end

    it 'ignores invalid characters' do
      source = '[bXc+.#blahCCC]'

      expect(parser.parse(source)).to eq [:cmdB, :cmdC, :cmdB, :cmdA]
    end
  end

  context 'multi char language' do
    let(:language) do
      {
        "command_size" => 3,
        "commands"=> {
          "cmdA" => "axa",
          "cmdB" => "byb",
          "cmdC" => "czc"
        }
      }
    end
    let(:parser) { Parser.new(language) }

    it 'parse source containing all available commands' do
      source = 'bybaxaczc'

      expect(parser.parse(source)).to eq [:cmdB, :cmdA, :cmdC]
    end

    it 'ignores invalid characters' do
      source = '[bXbybcczc+.#blbybaxahCCC]'

      expect(parser.parse(source)).to eq [:cmdB, :cmdC, :cmdB, :cmdA]
    end

    it 'ignores overlaps' do
      source = 'axaxa'

      expect(parser.parse(source)).to eq [:cmdA]
    end
  end
end
