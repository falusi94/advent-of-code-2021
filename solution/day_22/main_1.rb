# frozen_string_literal: true

require_relative 'command'

path = File.join(__dir__, 'input.txt')

cubes_on =
  File
  .readlines(path)
  .map { |line| Command.parse(line) }
  .each_with_object({}) do |command, cubes|
    command.each_coordinate { |x, y, z| cubes["#{x},#{y},#{z}"] = command.turn_on? }
  end

count = cubes_on.values.count { |v| v }

puts "There are #{count} cubes on"
