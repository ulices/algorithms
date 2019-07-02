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
    node_values = pre_order_traversal(@head, [])
    node_values.join(' ')
  end

  def in_order
    node_values = in_order_traversal(@head, [])
    node_values.join(' ')
  end

  alias_method :sort_values, :in_order

  def post_order
    node_values = post_order_traversal(@head, [])
    node_values.join(' ')
  end

  def not_recursive_in_order
    return 'empty' unless @head
    node_values = not_recursive_in_order_traversal(@head)
    node_values.join(' ')
  end

  def nodes_values
    # node_values = search_nodes(@head, [])
    node_values = pre_order_traversal(@head, [])
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

  def pre_order_traversal(current, node_values)
    return node_values unless current
    node_values << current.value
    pre_order_traversal(current.left, node_values)
    pre_order_traversal(current.right, node_values)
  end

  def in_order_traversal(current, node_values)
    return node_values unless current
    in_order_traversal(current.left, node_values)
    node_values << current.value
    in_order_traversal(current.right, node_values)
  end

  def post_order_traversal(current, node_values)
    return node_values unless current
    post_order_traversal(current.left, node_values)
    post_order_traversal(current.right, node_values)
    node_values << current.value
  end

  def not_recursive_in_order_traversal(current)
    stack = [current]
    node_values = []
    go_left = true
    while stack.size > 0
      if go_left
          while current.left
            stack.push(current)
            current = current.left
          end
        end

        node_values.push current.value

        if current.right
          current = current.right
          go_left = true
        else
          current = stack.pop
          go_left = false
        end
    end
    node_values
  end
end
