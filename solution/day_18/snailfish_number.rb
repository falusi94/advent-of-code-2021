# frozen_string_literal: true

class SnailfishNumber
  SplitLimitReachedError = Class.new(StandardError)

  State = Struct.new(:prev_node, :r_remainder, keyword_init: true) do
    def self.clean = new(r_remainder: 0)

    def increase_prev_node(l_remainder)
      if prev_node.nil?
        # no-op
      elsif prev_node.r_value.is_a?(Integer)
        prev_node.r_value += l_remainder
      elsif prev_node.l_value.is_a?(Integer)
        prev_node.l_value += l_remainder
      end
    end
  end

  Node = Struct.new(:l_value, :r_value, :nest_level, keyword_init: true) do
    def to_s = "[#{l_value},#{r_value}]"

    def to_a = [
      l_value.is_a?(Node) ? l_value.to_a : l_value,
      r_value.is_a?(Node) ? r_value.to_a : r_value
    ]

    def exploded? = nest_level >= 4
  end

  def initialize(expr) = @root = parse_node(expr)

  def self.parse(string) = new(eval(string))

  def reduce
    loop do
      prev_state = to_s
      begin
        explode
        split
      rescue SplitLimitReachedError
        # no-op
      end
      break if prev_state == to_s
    end
    self
  end

  def magnitude(node = @root, magnitude = 0)
    if !node.is_a?(Node)
      node
    else
      magnitude + magnitude(node.l_value) * 3 + magnitude(node.r_value) * 2
    end
  end

  def to_s = root.to_s

  def to_a = root.to_a

  def +(other)
    SnailfishNumber.new([to_a, other.to_a]).reduce
  end

  private

  def explode(node = @root, state = State.clean)
    if !node.is_a?(Node)
      r_remainder = state.r_remainder
      state.r_remainder = 0
      node + r_remainder
    elsif node.exploded?
      node.l_value = explode(node.l_value, state)
      node.r_value = explode(node.r_value, state)
      state.increase_prev_node(node.l_value)
      state.r_remainder = node.r_value

      0
    else
      node.l_value = explode(node.l_value, state)
      state.prev_node = node if node.l_value.is_a?(Integer)
      node.r_value = explode(node.r_value, state)
      state.prev_node = node if node.r_value.is_a?(Integer)

      node
    end
  end

  def split(node = @root, parent = nil)
    if node.is_a?(Node)
      l_value_before = node.l_value
      node.l_value = split(node.l_value, node)
      raise SplitLimitReachedError unless l_value_before == node.l_value

      r_value_before = node.r_value
      node.r_value = split(node.r_value, node)
      raise SplitLimitReachedError unless r_value_before == node.r_value

      node
    elsif node < 10
      node
    else
      number = node / 2.0
      Node.new(l_value: number.floor, r_value: number.ceil, nest_level: parent.nest_level + 1)
    end
  end

  def parse_node(expr, nest_level = 0)
    left, right = expr

    node = Node.new(nest_level: nest_level, l_value: left, r_value: right)

    node.l_value = parse_node(left, nest_level + 1) if left.is_a?(Array)
    node.r_value = parse_node(right, nest_level + 1) if right.is_a?(Array)

    node
  end

  attr_reader :root
end
