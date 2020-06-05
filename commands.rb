require "json"

class Command
  def initialize(command)
    @command = command
  end

  def run(current = nil, current_path = nil)
    raise "Unsupported operation"
  end
end

class NewCommand < Command
  def initialize(path)
    super("new")
    @path = ("output/#{path}").split('/')
    @name = @path[-1]
  end

  def run(current = nil, current_path = nil)
    unless current.nil? then
      puts "Another file is currently open.  Save before creating a new one."
      return current, current_path
    end

    # initial data
    data = Hash.new
    data["name"] = @name

    # write to output
    pathname = "#{@path.join('/')}.json"
    current_dir = ""
    for dir in @path do
      if dir.equal?(@path[-1]) then
        break
      end
      unless current_dir.length == 0 then
        current_dir += '/'
      end
      current_dir += dir
      unless Dir.exist?(current_dir) then
        Dir.mkdir(current_dir)
      end
    end
    File.open(pathname, "w") do |file|
      file.write(JSON.pretty_generate(data))
    end

    puts "New file opened at #{pathname}"
    return data, pathname
  end
end

class EditCommand < Command
  def initialize(name)
    super("edit")
    @name = name
  end

  def run(current = nil, current_path = nil)
    # check file exists
    pathname = "output/#{@name}.json"
    unless File.exist?(pathname) and File.file?(pathname) and not File.empty?(pathname) then
      puts "Cannot find file #{pathname}"
      return nil, nil
    end

    # parse to JSON
    data = JSON.parse(File.read(pathname))
    return data, pathname
  end
end

class GetCommand < Command
  def initialize(key)
    super("get")
    @key = key
  end

  def run(current = nil, current_path = nil)
    if current.nil? then
      puts "There is no file open."
    else
      key_args = @key.split('.')
      subhash = current
      for arg in key_args do
        subhash = subhash[arg]
        if subhash.nil? then
          puts "The path #{@key} has no value."
          break
        elsif subhash.is_a?(Hash) then
          next
        else
          puts subhash
          break
        end
      end
    end
    return current, current_path
  end
end

class SetCommand < Command
  def initialize(key, value)
    super("set")
    @key = key
    @value = value
  end

  def run(current = nil, current_path = nil)
    if current.nil? then
      puts "There is no file open."
    else
      key_args = @key.split('.')
      subhash = current
      for arg in key_args do
        if arg.equal?(key_args[-1])
          if @value.nil? then
            subhash.delete(arg)
          else
            subhash[arg] = @value
          end
          break
        end
        inspect = subhash[arg]
        unless inspect.is_a?(Hash) then
          inspect = Hash.new
          subhash[arg] = inspect
        end
        subhash = inspect
      end
    end
    return current, current_path
  end
end

class DelCommand < SetCommand
  def initialize(key)
    super(key, nil)
  end
end

class SaveCommand < Command
  def initialize
    super("save")
  end

  def run(current = nil, current_path = nil)
    if current.nil? then
      puts "There is no file open."
    else
      File.open(current_path, "w") do |file|
        file.write(JSON.pretty_generate(current))
      end
    end
    return current, current_path
  end
end

class CloseCommand < Command
  def initialize
    super("close")
  end

  def run(current = nil, current_path = nil)
    if current.nil? then
      puts "There is no file open."
    end
    return nil, nil
  end
end
