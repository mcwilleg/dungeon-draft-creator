class Command
  def initialize(command)
    @command = command
  end

  def run
    raise "Unsupported operation"
  end
end

class NewCommand < Command
  def initialize(type, name)
    super("new")
    @type = type
    @name = name
  end

  def run
    file = File.new(name + ".dnd", "w")
  end
end

class OpenCommand < Command
  def initialize(file)
    super("open")
    @file = file
  end

  def run
  end
end
