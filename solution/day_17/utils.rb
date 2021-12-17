# frozen_string_literal: true

# Input
# target area: x=150..193, y=-136..-86'

Vector = Struct.new(:x, :y, keyword_init: true) do
  def +(other)
    self.class.new(x: x + other.x, y: y + other.y)
  end
end

class Map
  def initialize(x_range, y_range)
    @x_range = x_range
    @y_range = y_range
  end

  def hit?(position) = @x_range.cover?(position.x) && @y_range.cover?(position.y)

  def passed_target?(position) = @x_range.last < position.x || @y_range.first > position.y

  attr_reader :x_range, :y_range
end

State = Struct.new(:position, :velocity, :y_max, keyword_init: true) do
  def iterate
    self.position += velocity
    self.y_max     = [y_max, position.y].max
    self.velocity  = next_velocity
  end

  private

  def next_velocity
    case velocity
    in {x: 0, y:}
      Vector.new(x: 0, y: y - 1)
    in {x:, y:} if x.positive?
      Vector.new(x: x - 1, y: y - 1)
    in {x:, y:} if x.negative?
      Vector.new(x: x + 1, y: y - 1)
    end
  end
end
