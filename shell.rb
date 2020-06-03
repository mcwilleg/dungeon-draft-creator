require_relative "parser.rb"

puts "Dungeon Draft Creator v1.0"

begin
  print "ddc > "
  input = gets.chomp
  cmd = parse_command(input)

  # ignore invalid commands
  unless cmd.nil? then
    cmd.run
  end
end until input == "exit"
