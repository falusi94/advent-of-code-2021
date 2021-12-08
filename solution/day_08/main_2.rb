# frozen_string_literal: true

#  aaaa    ....    aaaa    aaaa    ....
# b    c  .    c  .    c  .    c  b    c
# b    c  .    c  .    c  .    c  b    c
#  ....    ....    dddd    dddd    dddd
# e    f  .    f  e    .  .    f  .    f
# e    f  .    f  e    .  .    f  .    f
#  gggg    ....    gggg    gggg    ....

#  aaaa    aaaa    aaaa    aaaa    aaaa
# b    .  b    .  .    c  b    c  b    c
# b    .  b    .  .    c  b    c  b    c
#  dddd    dddd    ....    dddd    dddd
# .    f  e    f  .    f  e    f  .    f
# .    f  e    f  .    f  e    f  .    f
#  gggg    gggg    ....    gggg    gggg

#  0000       Mapping of DisplayMapper
# 1    2        Each segment corresponds to the index of mapping
# 1    2
#  3333
# 4    5
# 4    5
#  6666

path = File.join(__dir__, 'input.txt')

class DisplayMapper
  NUMBERS = %w[012456 25 02346 02356 1235 01356 013456 025 0123456 012356]

  def initialize(samples)
    @mapping = [%w[a b c d e f g]] * 7

    mark_numbers(samples)

    deduct until resolved?
    @mapping.flatten!
  end

  def decode(segments)
    code = segments.chars.map { |segment| @mapping.index(segment) }.sort.join
    NUMBERS.index(code)
  end

  private

  def mark_numbers(samples)
    two, three, four, five, six, _seven =
      samples
      .sort_by(&:length)
      .chunk_while { |a, b| a.length == b.length }
      .map { |segments| segments.map(&:chars).inject(:&) }

    mark([2, 5], two) # Number 1
    mark([0, 2, 5], three) # Number 7
    mark([1, 2, 3, 5], four) # Number 4
    mark([0, 3, 6], five) # Number 2, 3, 5
    mark([0, 1, 5, 6], six) # Number 0, 6, 9
  end

  def deduct
    found = @mapping.select { |candidates| candidates.count == 1 }.flatten
    @mapping.map! { |candidates| candidates.count == 1 ? candidates : candidates - found }
  end

  def resolved? = @mapping.none? { |candidate| candidate.count > 1 }

  def mark(segments, candidates) = segments.each { |i| @mapping[i] &= candidates }
end

sum =
  File
  .readlines(path)
  .map { |line| line.split('|') }
  .map { |digit_string, output_string| [digit_string.split, output_string.split] }
  .map { |digits, outputs| [DisplayMapper.new(digits), outputs] }
  .map { |mapper, outputs| outputs.map { |segments| mapper.decode(segments) } }
  .map { |digits| digits.join.to_i }
  .sum

puts "Sum of outputs is #{sum}"
