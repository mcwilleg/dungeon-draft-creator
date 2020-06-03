require "json"

class Command
  def initialize(command)
    @command = command
  end

  def run
    raise "Unsupported operation"
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

class NewCommand < Command
  def initialize(type, name)
    super("new")
    @type = type
    @name = name
  end

  def run
    # initial data
    data = Hash.new
    data["type"] = @type
    data["display"] = @name

    # write to output
    File.open("output/" + @name + ".json", "w") do |file|
      file.write(JSON.pretty_generate(data))
    end
  end
end
