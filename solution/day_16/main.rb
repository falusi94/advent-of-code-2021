# frozen_string_literal: true

require_relative 'utils'

path = File.join(__dir__, 'input.txt')

hex_data = File.read(path)
bin_data = hex_to_binary(hex_data).chars
result = Packet.parse(bin_data)

puts "The version number sum is #{result.version_sum} and the result is #{result.result}"
