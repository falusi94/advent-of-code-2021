# frozen_string_literal: true

COMMAND_MATCHER = /(on|off) x=(-?\d*)..(-?\d*),y=(-?\d*)..(-?\d*),z=(-?\d*)..(-?\d*)/

Command = Struct.new(:command, :x_range, :y_range, :z_range) do
  def self.parse(line)
    data = line.match(COMMAND_MATCHER)

    new(
      data[1],
      data[2].to_i..data[3].to_i,
      data[4].to_i..data[5].to_i,
      data[6].to_i..data[7].to_i
    )
  end

  def turn_on? = command == 'on'

  def each_coordinate(max: 50)
    limited_x_rage = ([x_range.first, -max].max..[x_range.last, max].min)
    limited_y_rage = ([y_range.first, -max].max..[y_range.last, max].min)
    limited_z_rage = ([z_range.first, -max].max..[z_range.last, max].min)

    limited_x_rage.each do |x|
      limited_y_rage.each do |y|
        limited_z_rage.each do |z|
          yield(x, y, z)
        end
      end
    end
  end
end
