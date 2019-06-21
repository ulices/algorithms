class BinaryTreeNode
  attr_accessor :value, :left, :right

  def initialize(value)
    @value = value
  end

  def left?
    !left.nil?
  end

  def right?
    !right.nil?
  end
end
