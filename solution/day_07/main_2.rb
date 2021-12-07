# frozen_string_literal: true

path = File.join(__dir__, 'input.txt')

@positions = File.read(path).chomp.split(',').map(&:to_i)
min, max   = @positions.minmax

@cache = {}

def consumption(current_position, destination)
  min, max = [current_position, destination].minmax

  @cache[max - min] ||
    (@cache[max - min] = (min..max).inject(0) { |total, position| total + position - min })
end

def sum_consumption(at) = @positions.map { |position| consumption(position, at) }.sum

position = (min..max).min { |a, b| sum_consumption(a) <=> sum_consumption(b) }

puts "Consumption is #{sum_consumption(position)} at position: #{position}"
