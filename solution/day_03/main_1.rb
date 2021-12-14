# frozen_string_literal: true

path = File.join(__dir__, 'input.txt')

gamma_bin =
  File
  .readlines(path, chomp: true)
  .map(&:chars)
  .transpose
  .map(&:tally)
  .map { |hash| hash['0'] < hash['1'] ? '1' : '0' }
  .join

epsilon_bin = gamma_bin.chars.map { |char| char == '1' ? '0' : '1' }.join

gamma   = gamma_bin.to_i(2)
epsilon = epsilon_bin.to_i(2)

puts 'Part #1'
puts "gamma: #{gamma}, epsilon: #{epsilon}"
puts "gamma * epsilon: #{gamma * epsilon}"
