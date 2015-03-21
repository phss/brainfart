require_relative '../src/interpreter'

RSpec.describe Interpreter, '#interpret' do
  let(:output) { StringIO.new }
  let(:interpreter) { Interpreter.new(output) }

  it 'interprets a hello world BF code' do
    interpreter.interpret('++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>' + 
                          '---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++.')

    expect(output.string).to eq "Hello World!\n"
  end
end
