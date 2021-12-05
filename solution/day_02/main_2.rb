# frozen_string_literal: true

path = File.join(__dir__, 'input.txt')

OtherVector = Struct.new(:x, :y, :aim, keyword_init: true) do
  def +(other)
    self.class.new(x: x + other.x, y: y + other.y + aim * other.x, aim: aim + other.aim)
  end
end

OtherMovement = Struct.new(:direction, :step) do
  def to_vector
    case direction.to_sym
    when :up
      OtherVector.new(x: 0, y: 0, aim: -step)
    when :down
      OtherVector.new(x: 0, y: 0, aim: step)
    when :forward
      OtherVector.new(x: step, y: 0, aim: 0)
    end
  end
end

out =
  File
  .readlines(path)
  .map { |line| line.split(' ') }
  .map { |direction, step| OtherMovement.new(direction, step.to_i) }
  .map(&:to_vector)
  .inject(OtherVector.new(x: 0, y: 0, aim: 0)) do |previous_vector, movement_vector|
    previous_vector + movement_vector
  end

puts 'Part #2'
puts out
puts "x * y: #{out.x * out.y}"
