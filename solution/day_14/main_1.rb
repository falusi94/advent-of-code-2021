# frozen_string_literal: true

path = File.join(__dir__, 'input.txt')

template, rules = File.read(path).split("\n\n")

@rules_map =
  rules
  .lines(chomp: true)
  .map { |line| line.split(' -> ') }
  .each_with_object({}) { |(pattern, insertion), hash| hash[pattern] = insertion }

final_polimer = 10.times.inject(template.chars) do |polimer|
  [].tap do |new_polimer|
    polimer.each_cons(2) do |pair|
      new_polimer << pair.first

      insertion = @rules_map[pair.join]

      new_polimer << insertion if insertion
    end

    new_polimer << polimer.last
  end
end

(min, *), (max, *) = final_polimer.tally.invert.minmax

puts "Result is #{max - min}"
