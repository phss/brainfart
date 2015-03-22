class Parser

  def initialize(config)
    @command_size = config['command_size']
    @command_to_instruction = config['commands'].map do |name, instruction|
      [instruction, name.to_sym]
    end.to_h
  end

  def parse(source)
    commands_from(source).map { |command| @command_to_instruction[command] }
  end

 private

  def commands_from(source)
    available_commands = @command_to_instruction.keys
    commands = []
    characters = source.split('')

    while !characters.empty?
      possible_command = characters[0..@command_size-1].join
      if available_commands.include?(possible_command)
        commands << possible_command
        characters.shift(@command_size)
      else
        characters.shift
      end
    end

    return commands
  end

end
