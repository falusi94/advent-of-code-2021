# frozen_string_literal: true

path = File.join(__dir__, 'input.txt')

gamma_bin =
  File
  .readlines(path)
  .map(&:chomp)
  .map(&:chars)
  .transpose
  .map(&:tally)
  .map { |hash| hash['0'] < hash['1'] ? '1' : '0' }
  .join

epsilon_bin = gamma_bin.chars.map { |char| char == '1' ? '0' : '1' }.join

gamma   = eval "0b#{gamma_bin}"
epsilon = eval "0b#{epsilon_bin}"

puts 'Part #1'
puts "gamma: #{gamma}, epsilon: #{epsilon}"
puts "gamma * epsilon: #{gamma * epsilon}"
