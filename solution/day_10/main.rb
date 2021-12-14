# frozen_string_literal: true

path = File.join(__dir__, 'input.txt')

ERROR_SCORE_MAPPING = {
  ')' => 3,
  ']' => 57,
  '}' => 1_197,
  '>' => 25_137
}

AUTOCOMPLETE_SCORE_MAPPING = {
  ')' => 1,
  ']' => 2,
  '}' => 3,
  '>' => 4
}

def process(line)
  line.chars.inject([]) do |stack, char|
    case [char, stack.last]
    in ['(', *] then stack << ')'
    in ['[', *] then stack << ']'
    in ['{', *] then stack << '}'
    in ['<', *] then stack << '>'
    in [current, expected] if current == expected then stack[..-2]
    else return char
    end
  end
end

corrupted_lines, incomplete_lines =
  File
  .readlines(path, chomp: true)
  .map { |line| process(line) }
  .partition { |result| result.is_a?(String) }

error_score = corrupted_lines.map { |incorrect_char| ERROR_SCORE_MAPPING[incorrect_char] }.sum

puts "The eror score is #{error_score}"

autocomplete_scores =
  incomplete_lines
  .map { |missing_chars| missing_chars.reverse.map { |char| AUTOCOMPLETE_SCORE_MAPPING[char] } }
  .map { |scores| scores.inject(0) { |total, score| total * 5 + score } }
  .sort

autocomplete_score = autocomplete_scores[(autocomplete_scores.count - 1) / 2]

puts "The autocomplete score is #{autocomplete_score}"
