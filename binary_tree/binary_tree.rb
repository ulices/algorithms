require './binary_tree_node.rb'

class BinaryTree
  attr_accessor :head, :count

  def initialize
    @head = nil
    @count = 0
  end

  def add(value)
    @count +=1
    return @head = BinaryTreeNode.new(value) unless @head
    add_to(@head, value)
  end

  def find_node_by(value)
    current, previous_node = find_node(@head, value, @head)
    current
  end

  def pre_order
    node_values = visit_pre_order(@head, [])
    node_values.join(' ')
  end

  def in_order
    node_values = visit_in_order(@head, [])
    node_values.join(' ')
  end

  alias_method :sort_values, :in_order

  def post_order
    node_values = visit_post_order(@head, [])
    node_values.join(' ')
  end

  def nodes_values
    # node_values = search_nodes(@head, [])
    node_values = visit_pre_order(@head, [])
    node_values.join(' ')
  end

  def remove(value)
    node, previous = find_node(@head, value, @head)
    return node if node == 'not exist'

    return promote_child(previous, node, nil) if node.left.nil? && node.right.nil?
    return promote_child(previous, node, node.left) if node.right.nil?
    return promote_child(previous, node, node.right) if node.right.left.nil?
    unless node.right.left.nil?
      left_most, previous_left = find_left_most(node.right, node)
      remove_from(tail: previous_left, node: left_most)
      return promote_child(previous, node, left_most)
    end
  end

private

  def add_to(current, value)
    if value < current.value
      return add_to_left(current, value) if current.left.nil?
      current = current.left
    else
      return add_to_right(current, value) if current.right.nil?
      current = current.right
    end

    add_to(current, value)
  end

  def add_to_left(node, value)
    node.left = BinaryTreeNode.new(value)
  end

  def add_to_right(node, value)
    node.right = BinaryTreeNode.new(value)
  end

  def find_left_most(current_head, previous_head)
    return find_left_most(current_head.left, current_head) unless current_head.left.nil?
    return find_left_most(current_head.right, current_head) unless current_head.right.nil?
    return [current_head, previous_head]
  end

  def find_node(current, value, previous_node)
    return 'not exist' if current.nil?
    return [current, previous_node] if current.value == value
    previous_node = current
    return find_node(current.left, value, current) if value < current.value
    return find_node(current.right, value, current)
  end

  def promote_child(previous, node, promoted)
    previous.left = promoted if previous.left == node
    previous.right = promoted if previous.right == node
    promoted.left = node.left  if promoted && promoted.left.nil? && !node.left.nil?
    promoted.right = node.right if promoted && promoted.right.nil? && !node.right.nil?
    node = nil
  end

  def remove_from(tail:, node:)
    tail.left = nil if tail.left == node
    tail.rigth = nil if tail.right == node
  end

  def promote_left_most(previous, node, promoted)
    previous.right = nil if previous.right == child
    previous.left = nil if previous.left == child
  end

  def search_nodes(current, node_values)
    node_values << current.value
    search_nodes(current.left, node_values) if current.left
    search_nodes(current.right, node_values) if current.right
    node_values
  end

  def visit_pre_order(current, node_values)
    return node_values unless current
    node_values << current.value
    visit_pre_order(current.left, node_values)
    visit_pre_order(current.right, node_values)
  end

  def visit_in_order(current, node_values)
    return node_values unless current
    visit_in_order(current.left, node_values)
    node_values << current.value
    visit_in_order(current.right, node_values)
  end

  def visit_post_order(current, node_values)
    return node_values unless current
    visit_post_order(current.left, node_values)
    visit_post_order(current.right, node_values)
    node_values << current.value
  end
end
