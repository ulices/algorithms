require 'minitest/autorun'
require './binary_tree'

describe BinaryTree do

  def populate_tree(values)
    values.each{|value| @binary_tree.add(value) }
  end

  before do
    @binary_tree = BinaryTree.new()
  end

  describe "When binary tree is empty" do
    it "must add a new node as head" do
      @binary_tree.add(3)
      @binary_tree.head.value.must_equal(3)
    end
  end

  describe "When adding a new node" do
    before do
      @binary_tree.add(3)
    end

    describe "with a small value" do
      it "must added to the left" do
        @binary_tree.add(1)
        @binary_tree.head.left.value.must_equal(1)
      end
    end

    describe "with a larger value" do
      it "must added to the right" do
        @binary_tree.add(6)
        @binary_tree.head.right.value.must_equal(6)
      end
    end
  end

  describe "When adding multiple nodes" do
    before do
      populate_tree([4, 6, 2, 1, 3, 5, 7])
    end

    it "must have corrent amount of nodes" do
      @binary_tree.count.must_equal(7)
    end

    it "must diplay node values in order" do
       @binary_tree.nodes_values.must_equal('4 2 1 3 6 5 7')
    end

    it "must sort elements" do
       @binary_tree.sort_values.must_equal('1 2 3 4 5 6 7')
    end
  end

  describe "Find nodes" do
    before do
      populate_tree([4, 6, 2, 1, 3, 5, 7])
    end

    it "must find a node by each value" do
      [1, 2, 3, 4 ,5 ,6 ,7].each do |value|
        node = @binary_tree.find_node_by(value)

        node.value.must_equal(value)
      end
    end

    it "must find a node by value at the left-end of the tree" do
      node = @binary_tree.find_node_by(1)

      node.value.must_equal(1)
      node.left.must_be_nil
      node.right.must_be_nil
    end

    it "must find a node by value at the right-end of the tree" do
      node = @binary_tree.find_node_by(7)

      node.value.must_equal(7)
      node.left.must_be_nil
      node.right.must_be_nil
    end

    it "must return 'not exist' is node is not in the tree" do
      @binary_tree.find_node_by(8).must_equal("not exist")
    end
  end

  describe "Remove nodes" do
    describe 'when removed node has no chlidren' do
      before do
        populate_tree([4, 6, 2, 1, 3, 5, 7])
      end

      it "must restructure the binary tree" do
        @binary_tree.remove(1)

        @binary_tree.nodes_values.must_equal('4 2 3 6 5 7')
      end
    end

    describe 'when removed node has no right child' do
      before do
        populate_tree([4, 8, 2, 1, 3, 6, 5, 7])
      end

      it "must restructure the binary tree" do
        @binary_tree.remove(8)

        @binary_tree.nodes_values.must_equal('4 2 1 3 6 5 7')
      end
    end

    describe 'when removed node right child has no left' do
      before do
        populate_tree([4, 6, 2, 1, 3, 5, 7, 8])
      end

      it "must restructure the binary tree" do
        @binary_tree.remove(6)

        @binary_tree.nodes_values.must_equal('4 2 1 3 7 5 8')
      end
    end

    describe 'when removed node right child has left child' do
      before do
        populate_tree([4, 6, 2, 1, 3, 5, 8, 7])
      end

      it "must restructure the binary tree" do
        @binary_tree.remove(6)

        @binary_tree.nodes_values.must_equal('4 2 1 3 7 5 8')
      end
    end
  end

  describe "Traversals" do
    before do
      populate_tree([4, 2, 1, 3, 6, 5, 7])
    end

    describe "Pre-Order" do
      it "must pre-ordered the nodes" do
        @binary_tree.pre_order.must_equal('4 2 1 3 6 5 7')
      end
    end

    describe "In-Order" do
      it "must in-ordered the nodes" do
        @binary_tree.in_order.must_equal('1 2 3 4 5 6 7')
      end
    end

    describe "Post-Order" do
      it "must post-ordered the nodes" do
        @binary_tree.post_order.must_equal('1 3 2 5 7 6 4')
      end
    end

    describe "Not recursive" do
      describe "In-Order" do
        it "must in-ordered the nodes" do
          @binary_tree.not_recursive_in_order.must_equal('1 2 3 4 5 6 7')
        end
      end
    end
  end
end
