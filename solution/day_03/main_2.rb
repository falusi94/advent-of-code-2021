# frozen_string_literal: true

path = File.join(__dir__, 'input.txt')

def bit_count_at(input, position) = input.transpose.map(&:tally).at(position)

def find_rating(input)
  (0...input.first.length).inject(input) do |previous_list, i|
    break previous_list if previous_list.count == 1

    bit_counts  = bit_count_at(previous_list, i)
    fitting_bit = yield(bit_counts)

    previous_list.select { |bits| bits[i] == fitting_bit }
  end.first.join
end

input_list = File.readlines(path, chomp: true).map(&:chars)
oxygen_gen_rating_bin =
  find_rating(input_list) { |bit_counts| bit_counts['0'] > bit_counts['1'] ? '0' : '1' }
scrubber_rating_bin   =
  find_rating(input_list) { |bit_counts| bit_counts['0'] > bit_counts['1'] ? '1' : '0' }

oxygen_gen_rating = oxygen_gen_rating_bin.to_i(2)
scrubber_rating   = scrubber_rating_bin.to_i(2)

puts 'Part #2'
puts "oxygen_gen_rating: #{oxygen_gen_rating}, scrubber_rating: #{scrubber_rating}"
puts "oxygen_gen_rating * scrubber_rating: #{oxygen_gen_rating * scrubber_rating}"
