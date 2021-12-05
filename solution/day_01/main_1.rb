# frozen_string_literal: true

path = File.join(__dir__, 'input.txt')

changes = []

File.readlines(path).map(&:to_i).inject(nil) do |previous_depth, depth|
  next depth if previous_depth.nil?

  changes << (previous_depth < depth ? :increased : :decreased)
  depth
end

puts 'Part #1'
puts changes.tally
