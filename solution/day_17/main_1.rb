# frozen_string_literal: true

require_relative 'utils'

@map    = Map.new((150..193), (-136..-86))
@y_max  = 0

(1..@map.x_range.last).each do |velocity_x|
  (0..- 2 * @map.y_range.last).each do |velocity_y|
    state = State.new(
      position: Vector.new(x: 0, y: 0),
      velocity: Vector.new(x: velocity_x, y: velocity_y),
      y_max:    0
    )

    loop do
      state.iterate

      break @y_max = [@y_max, state.y_max].max if @map.hit?(state.position)

      break if @map.passed_target?(state.position)
    end
  end
end

puts "Maximum y position is #{@y_max}"
