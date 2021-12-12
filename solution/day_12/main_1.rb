# frozen_string_literal: true

require_relative 'utils'

map = Map.new

@paths = []

def visit_cave(cave, path = [])
  @paths << (path + [cave]) && return if cave.end?

  return if cave.small? && path.include?(cave)

  cave.connected_caves.each { |connected_cave| visit_cave(connected_cave, path + [cave]) }
end

visit_cave(map.start)

puts "There are #{@paths.count} paths"
