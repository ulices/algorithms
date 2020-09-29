# Write a file system class, which has two functions: create, and get
# create("/a",1)
# get("/a") //get 1
# create("/a/b",2)
# get("/a/b") //get 2
# create("/c/d",1) //Error, because "/c" is not existed
# get("/c") //Error, because "/c" is not existed
#
# class structure 
# node
#  -- key
#  -- value
#
# node_mgr
#   -- array of nodes
# a:
#  value: 1
#  b:
#   value: 2
#

require 'minitest/autorun'
require 'byebug'

class Node
  attr_accessor :key, :value

  def initialize(key, value)
    @key = key
    @value = value
  end
end

class FileSystem
  attr_accessor :nodes

  def initialize
    @nodes = []
  end

  def create(keys, value)
    path = retrieve_keys(keys)

    return nodes << Node.new(path[0], value) if path.count == 1

    current_node = root_node(path[0])
    return "Error because \"/#{path[0]}\" is not existed" if current_node.nil?

    new_node = find_node(path.last, current_node)
  
    current_node.value = Node.new(path.last, value)
  end

  def find_node(key, node)
    return 'empty spot' unless node.is_a?(Node)
    return node if node.key == key
    find_node(key, node.value)
  end

  def get(keys)
    path = retrieve_keys(keys)
    current_node = root_node(path[0])
    return "Error because \"/#{path[0]}\" is not existed" if current_node.nil?

    node = find_node(path.last, current_node)
    node.value
  end

  def root_node(key)
    nodes.find{|node| node.key == key }
  end

  def retrieve_keys(keys)
    keys.split("/").reject(&:empty?)
  end
end


describe FileSystem do
  it 'creates a node and storage a value' do
    file_system = FileSystem.new
    file_system.create('/a', 1)
    assert_equal(1, file_system.get('/a'))

    file_system.create('/a/b', 2)
    assert_equal(2, file_system.get('/a/b'))

    assert_equal('Error because "/c" is not existed', file_system.create('/c/d', 1))
    assert_equal('Error because "/c" is not existed', file_system.get('/c'))
  end

end
