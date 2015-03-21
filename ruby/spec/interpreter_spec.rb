require_relative '../src/interpreter'

RSpec.describe Interpreter, '#interpret' do
  it 'interprets hello world' do
    interpreter = Interpreter.new
    code = '++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++.'

    expect(interpreter.interpret(code)).to eq 'Hello world!'
  end
end
