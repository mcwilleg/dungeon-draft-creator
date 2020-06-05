require_relative "parser.rb"

puts "Dungeon Draft Creator v1.0"

$current = nil
$current_path = nil

begin
  print "ddc "
  unless $current.nil? then
    print "(#{$current["name"]}) "
  end
  print "> "
  input = gets.chomp
  cmd = parse_command(input)

  # ignore invalid commands
  unless cmd.nil? then
    $current, $current_path = cmd.run($current, $current_path)
  end
end until input == "exit"
