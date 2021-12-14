# frozen_string_literal: true

path      = File.join(__dir__, 'input.txt')
heightmap = File.readlines(path, chomp: true).map { |line| line.split('').map(&:to_i) }

local_minimums = []

heightmap.each.with_index do |row, row_i|
  row.each.with_index do |height, col_i|
    next if col_i.positive? && height >= row[col_i - 1] ||
            row[col_i + 1] && height >= row[col_i + 1] ||
            row_i.positive? && height >= heightmap[row_i - 1][col_i] ||
            heightmap[row_i + 1] && height >= heightmap[row_i + 1][col_i]

    local_minimums << height
  end
end

sum = local_minimums.sum + local_minimums.count

puts "Sum of the risk levels #{sum}"
