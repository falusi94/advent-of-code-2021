# frozen_string_literal: true

require_relative '../../../solution/day_18/snailfish_number'

describe SnailfishNumber do
  describe '#reduce' do
    shared_examples 'it reduces to' do |input, output|
      context "when the input is #{input}" do
        subject(:reduced_number) { SnailfishNumber.new(input).reduce }

        it "returns #{output}" do
          expect(reduced_number.to_a).to eq(output)
        end
      end
    end

    describe 'explosion' do
      include_examples 'it reduces to', [[[[[9, 8], 1], 2], 3], 4], [[[[0, 9], 2], 3], 4]

      include_examples 'it reduces to', [7, [6, [5, [4, [3, 2]]]]], [7, [6, [5, [7, 0]]]]

      include_examples 'it reduces to', [[6, [5, [4, [3, 2]]]], 1], [[6, [5, [7, 0]]], 3]

      include_examples 'it reduces to', [[3, [2, [1, [7, 3]]]], [6, [5, [4, [3, 2]]]]],
                       [[3, [2, [8, 0]]], [9, [5, [7, 0]]]]

      include_examples 'it reduces to', [[3, [2, [8, 0]]], [9, [5, [4, [3, 2]]]]],
                       [[3, [2, [8, 0]]], [9, [5, [7, 0]]]]
    end

    describe 'split' do
      include_examples 'it reduces to', [10, 0], [[5, 5], 0]

      include_examples 'it reduces to', [11, 0], [[5, 6], 0]

      include_examples 'it reduces to', [12, 0], [[6, 6], 0]
    end

    include_examples 'it reduces to', [[[[[4, 3], 4], 4], [7, [[8, 4], 9]]], [1, 1]],
                     [[[[0, 7], 4], [[7, 8], [6, 0]]], [8, 1]]
  end

  describe '#+' do
    shared_examples 'adds up correctly' do |numbers, sum|
      context "when the input is #{numbers}" do
        it "returns #{sum}" do
          result = numbers.map { |number| SnailfishNumber.parse(number) }.inject(:+)

          expect(result.to_a).to eq(sum)
        end
      end
    end

    include_examples 'adds up correctly',
                     %w[
                       [[[[4,3],4],4],[7,[[8,4],9]]]
                       [1,1]
                     ],
                     [[[[0, 7], 4], [[7, 8], [6, 0]]], [8, 1]]

    include_examples 'adds up correctly', %w[[1,1] [2,2] [3,3] [4,4]],
                     [[[[1, 1], [2, 2]], [3, 3]], [4, 4]]

    include_examples 'adds up correctly', %w[[1,1] [2,2] [3,3] [4,4] [5,5]],
                     [[[[3, 0], [5, 3]], [4, 4]], [5, 5]]

    include_examples 'adds up correctly', %w[[1,1] [2,2] [3,3] [4,4] [5,5] [6,6]],
                     [[[[5, 0], [7, 4]], [5, 5]], [6, 6]]

    include_examples 'adds up correctly',
                     %w[
                       [[[0,[4,5]],[0,0]],[[[4,5],[2,6]],[9,5]]]
                       [7,[[[3,7],[4,3]],[[6,3],[8,8]]]]
                     ],
                     [[[[4, 0], [5, 4]], [[7, 7], [6, 0]]], [[8, [7, 7]], [[7, 9], [5, 0]]]]

    include_examples 'adds up correctly',
                     %w[
                       [[[0,[4,5]],[0,0]],[[[4,5],[2,6]],[9,5]]]
                       [7,[[[3,7],[4,3]],[[6,3],[8,8]]]]
                       [[2,[[0,8],[3,4]]],[[[6,7],1],[7,[1,6]]]]
                       [[[[2,4],7],[6,[0,5]]],[[[6,8],[2,8]],[[2,1],[4,5]]]]
                       [7,[5,[[3,8],[1,4]]]]
                       [[2,[2,2]],[8,[8,1]]]
                       [2,9]
                       [1,[[[9,3],9],[[9,0],[0,7]]]]
                       [[[5,[7,4]],7],1]
                       [[[[4,2],2],6],[8,7]]
                     ],
                     [[[[8, 7], [7, 7]], [[8, 6], [7, 7]]], [[[0, 7], [6, 6]], [8, 7]]]
  end

  describe '#magnitude' do
    shared_examples 'calculates magnitude correctly' do |number, magnitude|
      context "when the input is #{number}" do
        it "has a magnitude of #{magnitude}" do
          number = SnailfishNumber.parse(number)

          expect(number.magnitude).to eq(magnitude)
        end
      end
    end

    include_examples 'calculates magnitude correctly', '[9,1]', 29

    include_examples 'calculates magnitude correctly', '[[9,1],[1,9]]', 129
  end

  describe 'integration' do
    it 'parses, sums up & calculates correctly' do
      input = %w[
        [[[0,[5,8]],[[1,7],[9,6]]],[[4,[1,2]],[[1,4],2]]]
        [[[5,[2,8]],4],[5,[[9,9],0]]]
        [6,[[[6,2],[5,6]],[[7,6],[4,7]]]]
        [[[6,[0,7]],[0,9]],[4,[9,[9,0]]]]
        [[[7,[6,4]],[3,[1,3]]],[[[5,5],1],9]]
        [[6,[[7,3],[3,2]]],[[[3,8],[5,7]],4]]
        [[[[5,4],[7,7]],8],[[8,3],8]]
        [[9,3],[[9,9],[6,[4,9]]]]
        [[2,[[7,7],7]],[[5,8],[[9,3],[0,2]]]]
        [[[[5,2],5],[8,[3,7]]],[[5,[7,5]],[4,4]]]
      ]
      sum = input.map { |line| SnailfishNumber.parse(line) }.inject(:+)

      expect(sum.to_a).to eq([[[[6, 6], [7, 6]], [[7, 7], [7, 0]]],
                              [[[7, 7], [7, 7]], [[7, 8], [9, 9]]]])
      expect(sum.magnitude).to eq(4140)
    end
  end
end
