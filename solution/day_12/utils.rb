# frozen_string_literal: true

Cave = Struct.new(:name, :connected_caves) do
  def small? = name.downcase == name

  def end? = name == 'end'

  def start? = name == 'start'
end

class Map
  def initialize
    path         = File.join(__dir__, 'input.txt')
    @connections = File.readlines(path, chomp: true).map { |line| line.split('-') }

    set_caves
    set_connections
  end

  def start = @caves['start']

  private

  def set_caves
    @caves =
      @connections
      .flatten
      .uniq
      .each_with_object({}) { |name, hash| hash[name] = Cave.new(name, []) }
  end

  def set_connections
    @caves.each do |_name, cave|
      connected_caves =
        @connections
        .select { |a, b| a == cave.name || b == cave.name }
        .flatten
        .reject { |name| cave.name == name }
        .uniq

      cave.connected_caves = @caves.slice(*connected_caves).values
    end
  end
end
