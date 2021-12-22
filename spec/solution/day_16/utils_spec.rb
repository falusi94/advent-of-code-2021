# frozen_string_literal: true

require_relative '../../../solution/day_16/utils'

describe Packet do
  describe 'version' do
    shared_examples 'it sums the version' do |hex_input, expected_verion|
      context "when the input is #{hex_input}" do
        it "returns #{expected_verion}" do
          bin_data = hex_to_binary(hex_input).chars

          expect(Packet.parse(bin_data)).to have_attributes(version_sum: expected_verion)
        end
      end
    end

    include_examples 'it sums the version', '8A004A801A8002F478', 16
    include_examples 'it sums the version', '620080001611562C8802118E34', 12
    include_examples 'it sums the version', 'C0015000016115A2E0802F182340', 23
    include_examples 'it sums the version', 'A0016C880162017C3686B18A3D4780', 31
  end

  describe 'operations' do
    shared_examples 'it performs the operation' do |hex_input, expected_output|
      context "when the input is #{hex_input}" do
        it "returns #{expected_output}" do
          bin_data = hex_to_binary(hex_input).chars

          expect(Packet.parse(bin_data)).to have_attributes(result: expected_output)
        end
      end
    end

    include_examples 'it performs the operation', 'C200B40A82', 3 # sum
    include_examples 'it performs the operation', '04005AC33890', 54 # product
    include_examples 'it performs the operation', '880086C3E88112', 7 # min
    include_examples 'it performs the operation', 'CE00C43D881120', 9 # max
    include_examples 'it performs the operation', 'D8005AC2A8F0', 1 # 5 < 15
    include_examples 'it performs the operation', 'F600BC2D8F', 0 # 5 > 15
    include_examples 'it performs the operation', '9C005AC2F8F0', 0 # 5 == 15
    include_examples 'it performs the operation', '9C0141080250320F1802104A08', 1 # 1 + 3 == 2 * 2
  end
end
