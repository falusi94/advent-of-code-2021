# frozen_string_literal: true

class RiskLevelMap
  def initialize(risk_levels)
    @risk_levels = risk_levels
    @height      = risk_levels.count
    @width       = risk_levels.first.count
  end

  def minimum_risk
    @to_visit = [[0, 0]]
    @distances = { '0,0' => 0 }

    (@height * @width).times do
      x, y = @to_visit.min { |(x1, y1), (x2, y2)| distance_of(x1, y1) <=> distance_of(x2, y2) }

      prev_d = distance_of(x, y)

      break if x == @width - 1 && y == @height - 1

      visit(x - 1, y, prev_d) if x.positive?
      visit(x + 1, y, prev_d) if x + 1 < @width
      visit(x, y - 1, prev_d) if y.positive?
      visit(x, y + 1, prev_d) if y + 1 < @height

      @distances[key(x, y)] = Float::INFINITY

      @to_visit.delete([x, y])
    end

    @distances[key(@width - 1, @height - 1)]
  end

  private

  def key(x, y) = "#{x},#{y}"

  def distance_of(x, y) = @distances[key(x, y)] || Float::INFINITY

  def visit(x, y, prev_d)
    return if @distances[key(x, y)] == Float::INFINITY

    @to_visit << [x, y] unless @to_visit.include?([x, y])
    @distances[key(x, y)] = [distance_of(x, y), @risk_levels[y][x] + prev_d].min
  end
end
