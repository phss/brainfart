require 'yaml'
require_relative '../src/interpreter'
require_relative '../src/io'

RSpec.describe Interpreter, '#interpret' do
  let(:parser_config) { YAML.load_file('config/bf.yaml') }
  let(:output) { StringIO.new }
  let(:io) { IOUtil.new(StringIO.new, output) }
  let(:interpreter) { Interpreter.new(io) }
  let(:hello_world_instructions) do
    Parser.new(parser_config).parse(
      '++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>' + 
     '---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++.')
  end

  it 'interprets a hello world BF code' do
    interpreter.interpret(hello_world_instructions)

    expect(output.string).to eq "Hello World!\n"
  end
end
