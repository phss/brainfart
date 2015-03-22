require_relative '../src/interpreter'
require_relative '../src/io'

RSpec.describe Interpreter, '#interpret' do
  let(:parser_config) { {"command_size"=>1, "commands"=>{"move_right"=>">", "move_left"=>"<", "increment_value"=>"+", "decrement_value"=>"-", "output"=>".", "input"=>",", "jump_past"=>"[", "jump_back"=>"]"}} }
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
