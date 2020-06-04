require_relative "parser.rb"

puts "Dungeon Draft Creator v1.0"

unless Dir.exist?("output") then
  Dir.mkdir("output")
end
$current = nil

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
    $current = cmd.run($current)
  end
end until input == "exit"
