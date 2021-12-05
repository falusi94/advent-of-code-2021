# frozen_string_literal: true

require 'matrix'

path = File.join(__dir__, 'input.txt')

Line = Struct.new(:x1, :y1, :x2, :y2) do
  def horizontal? = y1 == y2

  def vertical? = x1 == x2

  def diagonal? = !horizontal? && !vertical?
end

class Diagram
  def initialize(max) = @fields = Matrix.zero(max + 1)

  def draw(line)
    if line.vertical?
      each(line.y1, line.y2) { |y| @fields[y, line.x1] += 1 }
    elsif line.horizontal?
      each(line.x1, line.x2) { |x| @fields[line.y1, x] += 1 }
    else
      direction = line.y1 < line.y2 ? 1 : -1

      each(line.x1, line.x2) { |x, i| @fields[line.y1 + i * direction, x] += 1 }
    end
  end

  def dangerous_field_count = @fields.to_a.flatten.count { |c| c >= 2 }

  private def enumerator_for(from, to) = from <= to ? (from..to) : from.downto(to)
  private def each(from, to, &block) = enumerator_for(from, to).each.with_index(&block)
end

coordinates =
  File
  .readlines(path)
  .map { |string_line| string_line.match(/(\d*),(\d*) -> (\d*),(\d*)/) }
  .map { |data| data.to_a.last(4).map(&:to_i) }

max = coordinates.flatten.max

diagram = Diagram.new(max)

coordinates.map { |data| Line.new(*data) }.reject(&:diagonal?).each { |line| diagram.draw(line) }

puts 'Part #1'
puts "Dangerous fields: #{diagram.dangerous_field_count}"

diagram = Diagram.new(max)

coordinates.map { |data| Line.new(*data) }.each { |line| diagram.draw(line) }

puts 'Part #2'
puts "Dangerous fields: #{diagram.dangerous_field_count}"
