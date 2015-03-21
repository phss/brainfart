require_relative '../src/interpreter'

RSpec.describe Interpreter, '#interpret' do
  let(:output) { StringIO.new }

  it 'interprets a hello world BF code' do
    interpreter = Interpreter.new(output)
    code = '++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++.'

    interpreter.interpret(code)

    expect(output.string).to eq 'Hello world!'
  end
end
