# frozen_string_literal: true

path = File.join(__dir__, 'input.txt')

Vector = Struct.new(:x, :y, keyword_init: true) do
  def +(other)
    self.class.new(x: x + other.x, y: y + other.y)
  end
end

Movement = Struct.new(:direction, :step) do
  def to_vector
    case direction.to_sym
    when :up
      Vector.new(x: 0, y: -step)
    when :down
      Vector.new(x: 0, y: step)
    when :forward
      Vector.new(x: step, y: 0)
    end
  end
end

out =
  File
  .readlines(path)
  .map { |line| line.split(' ') }
  .map { |direction, step| Movement.new(direction, step.to_i) }
  .map(&:to_vector)
  .inject(Vector.new(x: 0, y: 0)) do |previous_vector, movement_vector|
    previous_vector + movement_vector
  end

puts 'Part #1'
puts out
puts "x * y: #{out.x * out.y}"

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
