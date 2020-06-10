require_relative "parser.rb"

puts "JSON Writer"

$current = nil
$file_path = nil
$hash_path = ""

begin
  print "jw "
  unless $current.nil? then
    print "(#{$current["name"]}"
    unless $hash_path.empty? then
      print " #{$hash_path}"
    end
    print ") "
  end
  print "> "

  input = gets.chomp
  cmd = parse_command(input)

  # ignore invalid commands
  unless cmd.nil? then
    $current, $file_path, $hash_path = cmd.run($current, $file_path, $hash_path)
  end
end until input == "exit"
