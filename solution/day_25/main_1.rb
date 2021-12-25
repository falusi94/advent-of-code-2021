# frozen_string_literal: true

path = File.join(__dir__, 'input.txt')

EAST  = '>'
SOUTH = 'v'
EMPTY = '.'

map = File.readlines(path, chomp: true).map(&:chars)

def mask(array, mask) = array.map.with_index { |element, i| element if mask[i] }

def combine(array, other) = array.map.with_index { |element, i| element || other[i] }

def move_herd(state, direction)
  count         = state.count
  movement_mask = [].tap do |mask|
    state.each_cons(2) { |field, to_right| mask << (field == direction && to_right == EMPTY) }
    mask << (state.first == EMPTY && state.last == direction)
  end

  moves_from = mask([EMPTY] * count, movement_mask)
  moves_to   = mask([direction] * count, movement_mask.rotate(-1))

  state = combine(moves_from, state)
  combine(moves_to, state)
end

count = 0

loop do
  count += 1
  new_map = map.map { |line| move_herd(line, EAST) }
  new_map = new_map.transpose.map { |column| move_herd(column, SOUTH) }.transpose

  break if map == new_map

  map = new_map
end

puts "All cucumbers got stuck after #{count} step"
