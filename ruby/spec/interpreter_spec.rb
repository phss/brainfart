require_relative '../src/interpreter'

RSpec.describe Interpreter, '#interpret' do
  let(:output) { StringIO.new }
  let(:interpreter) { Interpreter.new(output) }
  let(:hello_world_instructions) do
    Parser.new.parse('++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>' + 
                     '---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++.')
  end

  it 'interprets a hello world BF code' do
    interpreter.interpret(hello_world_instructions)

    expect(output.string).to eq "Hello World!\n"
  end
end
