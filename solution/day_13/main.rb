# frozen_string_literal: true

path          = File.join(__dir__, 'input.txt')
points, folds = File.read(path).split("\n\n")

points = points.lines.map { |line| line.split(',').map(&:to_i) }
folds  =
  folds
  .lines
  .map { |line| line.match(/.*(x|y)=(\d*)/) }
  .map { |data| [data[1], data[2].to_i] }

max_x = points.map(&:first).max
max_y = points.map(&:last).max

fields = Array.new(max_y + 1) { [nil] * (max_x + 1) }.tap do |array|
  points.each { |x, y| array[y][x] = true }
end

def merge_lines(line1, line2)
  return line1 if line2.nil?
  return line2 if line1.nil?

  line1.map.with_index { |element1, i| element1 || line2[i] }
end

def fold(fields, axis, coord)
  fields = fields.transpose if axis == 'x'
  height = [coord, fields.count - coord - 1].max

  upper = fields[0...coord].reverse
  lower = fields[coord + 1..]

  new_fields = [].tap do |array|
    (height - 1).downto(0) do |i|
      array << merge_lines(upper[i], lower[i])
    end
  end

  axis == 'x' ? new_fields.transpose : new_fields
end

output = fold(fields, *folds.first)
count  = output.flatten.count { |element| !element.nil? }

puts "There are #{count} visible dots after the first fold"

puts 'Final code'
folds
  .inject(fields) { |previous_fields, fold| fold(previous_fields, *fold) }
  .map { |dots| dots.map { |visible| visible ? '#' : ' ' }.join }
  .each { |line| puts line }
