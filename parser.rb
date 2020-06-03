require_relative "commands.rb"

def parse_command (input_text)
  args = input_text.split

  return if args.length < 1

  if args[0] == "new" then
    return if args.length < 3
    return NewCommand.new(args[1], args[2])
  end
end
