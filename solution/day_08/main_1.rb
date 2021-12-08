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

path = File.join(__dir__, 'input.txt')

segment_by_chars_count =
  File
  .readlines(path)
  .map { |line| line.split('|').last }
  .map(&:split)
  .flatten
  .map { |segment| segment.chars.count }
  .tally

count = segment_by_chars_count.select { |k, _v| [2, 4, 3, 7].include?(k) }.values.sum

puts "The combined count of 1, 4, 7, 8 is #{count}"
