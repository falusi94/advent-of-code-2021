# frozen_string_literal: true

path = File.join(__dir__, 'input.txt')

HEX_BINARY_MAPPING = {
  '0' => '0000',
  '1' => '0001',
  '2' => '0010',
  '3' => '0011',
  '4' => '0100',
  '5' => '0101',
  '6' => '0110',
  '7' => '0111',
  '8' => '1000',
  '9' => '1001',
  'A' => '1010',
  'B' => '1011',
  'C' => '1100',
  'D' => '1101',
  'E' => '1110',
  'F' => '1111'
}

def hex_to_binary(hex_string) = hex_string.chars.map { |hex| HEX_BINARY_MAPPING[hex] }.join

@version_sum = 0

def parse_subpackets(data)
  operator_type = data.shift

  bits_to_take = operator_type == '0' ? 15 : 11
  length_bin   = data.shift(bits_to_take).join
  length       = length_bin.to_i(2)

  if operator_type == '0'
    content = data.shift(length)

    [].tap do |array|
      array << parse_packet(content) while content.any?
    end.flatten
  else
    length.times.map { parse_packet(data) }.flatten
  end
end

def parse_packet(data)
  version = data.shift(3)
  type_id = data.shift(3)

  @version_sum += version.join.to_i(2)

  case type_id.join
  when '100' # 4
    [].tap do |array|
      loop do
        literal = data.shift(5)

        array << literal.last(4).join
        break if literal.first == '0'
      end
    end.map { |el| el.to_i(2) }
  when '000'
    parse_subpackets(data).sum
  when '001'
    parse_subpackets(data).inject(1) { |el, product| product * el }
  when '010'
    parse_subpackets(data).min
  when '011'
    parse_subpackets(data).max
  when '101'
    first, second = parse_subpackets(data)
    first > second ? 1 : 0
  when '110'
    first, second = parse_subpackets(data)
    first < second ? 1 : 0
  when '111'
    first, second = parse_subpackets(data)
    first == second ? 1 : 0
  end
end

hex_data = File.read(path)
bin_data = hex_to_binary(hex_data).chars
result = parse_packet(bin_data)

puts "The version number sum is #{@version_sum} and the result is #{result}"
