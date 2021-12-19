# frozen_string_literal: true

require_relative 'risk_level_map'

path        = File.join(__dir__, 'input.txt')
risk_levels = File.readlines(path, chomp: true).map { |line| line.chars.map(&:to_i) }

map = RiskLevelMap.new(risk_levels)

puts "The minimum risk is #{map.minimum_risk}"
