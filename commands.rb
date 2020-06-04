require "json"

class Command
  def initialize(command)
    @command = command
  end

  def run(current = nil)
    raise "Unsupported operation"
  end
end

class NewCommand < Command
  def initialize(type, name)
    super("new")
    @type = type
    @name = name
  end

  def run(current = nil)
    unless current.nil? then
      puts "Another file is currently open.  Save before creating a new one."
      return current
    end

    # initial data
    data = Hash.new
    data["name"] = @name
    data["display"] = @name
    data["type"] = @type

    # write to output
    pathname = "output/#{@name}.json"
    File.open(pathname, "w") do |file|
      file.write(JSON.pretty_generate(data))
    end

    puts "New file opened at #{pathname}"
    return data
  end
end

class EditCommand < Command
  def initialize(name)
    super("edit")
    @name = name
  end

  def run(current = nil)
    # check file exists
    pathname = "output/#{@name}.json"
    unless File.exist?(pathname) and File.file?(pathname) and not File.empty?(pathname) then
      puts "Cannot find file #{pathname}"
      return
    end

    # parse to JSON
    data = JSON.parse(File.read(pathname))
    return data
  end
end

class SetCommand < Command
  def initialize(key, value)
    super("set")
    @key = key
    @value = value
  end

  def run(current = nil)
    if current.nil? then
      puts "There is no file open."
    else
      current[@key] = @value
    end
    return current
  end
end

class SaveCommand < Command
  def initialize
    super("save")
  end

  def run(current = nil)
    if current.nil? then
      puts "There is no file open."
    else
      pathname = "output/#{current["name"]}.json"
      File.open(pathname, "w") do |file|
        file.write(JSON.pretty_generate(current))
      end
    end
    return nil
  end
end
