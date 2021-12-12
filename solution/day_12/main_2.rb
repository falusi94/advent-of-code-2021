# frozen_string_literal: true

require_relative 'utils'

map = Map.new

@paths = []

def visit_cave(cave, path = [], double_visit = false)
  @paths << (path + [cave]) && return if cave.end?

  return if cave.start? && path.any? ||
            cave.small? && path.include?(cave) && double_visit ||
            cave.small? && path.count { |v| v == cave } == 2

  cave.connected_caves.each do |connected_cave|
    visit_cave(connected_cave, path + [cave], double_visit || path.include?(cave) && cave.small?)
  end
end

visit_cave(map.start)

puts "There are #{@paths.count} paths"
