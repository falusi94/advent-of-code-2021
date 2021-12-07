# frozen_string_literal: true

path = File.join(__dir__, 'input.txt')

@positions = File.read(path).chomp.split(',').map(&:to_i)
min, max   = @positions.minmax

def sum_consumption(at) = @positions.map { |position| (at - position).abs }.sum

position = (min..max).min { |a, b| sum_consumption(a) <=> sum_consumption(b) }

puts "Consumption is #{sum_consumption(position)} at position: #{position}"
