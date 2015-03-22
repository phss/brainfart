class Parser

  def initialize(config)
    @command_size = config['command_size']
    @command_to_instruction = config['commands'].map do |name, instruction|
      [instruction, name.to_sym]
    end.to_h
  end

  def parse(source)
    tokenize(source).map { |command| @command_to_instruction[command] }.compact
  end

 private

  def tokenize(source)
    source.split('').each_cons(@command_size).map(&:join)
  end

end
