# frozen_string_literal: true

path = File.join(__dir__, 'input.txt')

class Board
  attr_reader :index

  def initialize(fields_data)
    @fields = fields_data.lines(chomp: true).map(&:split)
  end

  def draw(number)
    @fields = fields.map { |line| line.map { |n| n == number ? :x : n } }
  end

  def win?
    fields.any? { |line| full_line?(line) } || fields.transpose.any? { |line| full_line?(line) }
  end

  def rest
    fields.flatten.reject { |field| field == :x }.map(&:to_i).sum
  end

  private

  def full_line?(line)
    line.all? { |field| field == :x }
  end

  attr_reader :fields
end

input   = File.open(path).read.split("\n\n")
numbers = input.shift.split(',')

boards = input.map { |fields_data| Board.new(fields_data) }

last_number = numbers.find do |number|
  boards.each { |board| board.draw(number) }

  break number.to_i if boards.any?(&:win?)
end

puts 'Part #1'
puts "Rest of winner * number: #{boards.find(&:win?).rest * last_number}"

boards = input.map { |fields_data| Board.new(fields_data) }

result = numbers.find do |number|
  last_boards = boards.reject(&:win?)

  boards.each { |board| board.draw(number) }

  break { number: number.to_i, board: last_boards.first } if boards.all?(&:win?)
end

puts 'Part #2'
puts "Rest of looser * number: #{result[:board].rest * result[:number]}"
