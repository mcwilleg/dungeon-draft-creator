require_relative "commands.rb"

def parse_command (input_text)
  args = input_text.split

  return if args.length < 1

  if args[0] == "new" then
    return if args.length < 3
    return NewCommand.new(args[1], args[2])
  elsif args[0] == "edit" then
    return if args.length < 2
    return EditCommand.new(args[1])
  elsif args[0] == "get" then
    return if args.length < 2
    return GetCommand.new(args[1])
  elsif args[0] == "set" then
    return if args.length < 3
    return SetCommand.new(args[1], args[2..-1].join(" "))
  elsif args[0] == "del" then
    return if args.length < 2
    return DelCommand.new(args[1])
  elsif args[0] == "save" then
    return SaveCommand.new
  elsif args[0] == "exit" then
    return
  else
    puts "Invalid command: #{args[0]}"
  end
end
