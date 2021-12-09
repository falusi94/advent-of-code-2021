# frozen_string_literal: true

path       = File.join(__dir__, 'input.txt')
@heightmap = File.readlines(path).map { |line| line.chomp.split('').map(&:to_i) }

coordinates = []

@heightmap.each.with_index do |row, row_i|
  row.each.with_index do |height, col_i|
    next if col_i.positive? && height >= row[col_i - 1] ||
            row[col_i + 1] && height >= row[col_i + 1] ||
            row_i.positive? && height >= @heightmap[row_i - 1][col_i] ||
            @heightmap[row_i + 1] && height >= @heightmap[row_i + 1][col_i]

    coordinates << [row_i, col_i]
  end
end

@visited = Array.new(@heightmap.count) { [nil] * @heightmap.first.count }

def visit(row, column)
  return [] if row.negative? || column.negative? ||
               @heightmap[row].nil? || @heightmap[row][column].nil? ||
               @heightmap[row][column] == 9 || @visited[row][column]

  @visited[row][column] = true

  [@heightmap[row][column]] + visit(row - 1, column) + visit(row + 1, column) +
    visit(row, column - 1) + visit(row, column + 1)
end

product =
  coordinates
  .map { |row, column| visit(row, column) }
  .map(&:count)
  .sort
  .last(3)
  .inject(:*)

puts "Product of the sizes of the three largest basins #{product}"
