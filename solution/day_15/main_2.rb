# frozen_string_literal: true

require_relative 'risk_level_map'

path = File.join(__dir__, 'input.txt')
file = File.read(path)

risk_levels = [].tap do |array|
  5.times do |y_offset|
    file.lines(chomp: true).each do |line|
      risk_levels = line.chars.map(&:to_i)

      array << 5.times.map do |x_offset|
        risk_levels.map do |risk_level|
          risk_level += x_offset + y_offset
          risk_level > 9 ? risk_level - 9 : risk_level
        end
      end.flatten
    end
  end
end

map = RiskLevelMap.new(risk_levels)

puts "The minimum risk is #{map.minimum_risk}"
