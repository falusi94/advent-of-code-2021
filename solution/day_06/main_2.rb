# frozen_string_literal: true

path = File.join(__dir__, 'input.txt')

initial_state = File.read(path).chomp.split(',').map(&:to_i)

class State
  def initialize(fishes)
    @count_of_fishes     = (0..6).map { |step| fishes.count(step) }
    @count_of_new_fishes = [0] * 2
  end

  def iterate
    new_fish_count = count_of_fishes[0]

    count_of_fishes.rotate!
    count_of_fishes[6] += count_of_new_fishes[0]

    count_of_new_fishes.rotate!
    count_of_new_fishes[1] = new_fish_count
  end

  def total_count = count_of_new_fishes.sum + count_of_fishes.sum

  attr_reader :count_of_fishes, :count_of_new_fishes
end

state = State.new(initial_state)

256.times.each { state.iterate }

puts "There are #{state.total_count} fish"
