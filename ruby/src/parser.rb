class Parser

  def initialize(config)
    @bf_to_instruction = config['commands'].map do |name, instruction|
      [instruction, name.to_sym]
    end.to_h
  end

  def parse(source)
    source.split('').map { |command| @bf_to_instruction[command] }.compact
  end

end
