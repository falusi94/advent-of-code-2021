# frozen_string_literal: true

require_relative 'snailfish_number'

path = File.join(__dir__, 'input.txt')

snailfish_numbers = File.readlines(path).map { |line| SnailfishNumber.parse(line) }

@max = 0

snailfish_numbers.permutation(2) { |num1, num2| @max = [@max, (num1 + num2).magnitude].max }

puts "The largest magnitude is #{@max}"
