# frozen_string_literal: true

path = File.join(__dir__, 'input.txt')

changes = []
windows = []

File.readlines(path).map(&:to_i).inject([]) do |previous_window, depth|
  window = (previous_window + [depth]).last(3)

  windows << window if window.length == 3
  window
end

windows.map(&:sum).inject(nil) do |previous_depth, depth|
  next depth if previous_depth.nil?

  changes << (previous_depth < depth ? :increased : :decreased)
  depth
end

puts 'Part #2'
puts changes.tally
