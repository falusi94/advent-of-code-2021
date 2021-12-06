# frozen_string_literal: true

path = File.join(__dir__, 'input.txt')

initial_state = File.read(path).chomp.split(',').map(&:to_i)

final_state = 80.times.inject(initial_state) do |previous_state|
  count = previous_state.count(0)

  previous_state.map { |x| x.zero? ? 6 : x - 1 } + [8] * count
end

puts "There are #{final_state.count} fish"
