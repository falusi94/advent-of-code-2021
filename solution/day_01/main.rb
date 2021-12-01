# frozen_string_literal: true

path = File.join(__dir__, 'input.txt')

def calculate_changes_of(input)
  changes = []

  input.inject(nil) do |previous_depth, depth|
    next depth if previous_depth.nil?

    changes << (previous_depth < depth ? :increased : :decreased)
    depth
  end

  changes
end

depth_values = File.readlines(path).map(&:to_i)
changes      = calculate_changes_of(depth_values)

puts 'Part #1'
puts changes.tally

windows = []

File.readlines(path).map(&:to_i).inject([]) do |previous_window, depth|
  window = (previous_window + [depth]).last(3)

  windows << window if window.length == 3
  window
end

depth_values = windows.map(&:sum)
changes      = calculate_changes_of(depth_values)

puts 'Part #2'
puts changes.tally
