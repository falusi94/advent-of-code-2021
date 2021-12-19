# frozen_string_literal: true

require_relative 'snailfish_number'

path = File.join(__dir__, 'input.txt')

sum = File.readlines(path).map { |line| SnailfishNumber.parse(line) }.inject(:+)

puts "The magnitude is #{sum.magnitude}"
