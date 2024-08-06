# frozen_string_literal: true

require_relative 'node'

class Tree
  attr_accessor :root

  def initialize(array)
    @root = build_tree(array)
  end

  def build_tree(array)
    return nil if array.empty?

    sorted_unique = array.uniq.sort
    root_index = sorted_unique.length / 2
    root = Node.new(sorted_unique[root_index])

    root.left = build_tree(sorted_unique[0...root_index])
    root.right = build_tree(sorted_unique[(root_index + 1)..])

    root
  end

  def insert(value)
    @root = insert_recursive(@root, value)
  end

  def find(value)
    find_recursive(@root, value)
  end

  def level_order
    return [] if @root.nil?

    result = []
    queue = [@root]

    until queue.empty?
      node = queue.shift
      block_given? ? yield(node) : result << node.data

      queue << node.left if node.left
      queue << node.right if node.right
    end

    block_given? ? nil : result
  end

  def inorder(&block)
    inorder_traversal(@root, [], &block)
  end

  def preorder(&block)
    preorder_traversal(@root, [], &block)
  end

  def postorder(&block)
    postorder_traversal(@root, [], &block)
  end

  def height(node)
    return nil if node.nil?
    return -1 unless contains?(node)

    height_recursive(node)
  end

  def depth(node)
  end

  def balanced?
  end

  def rebalance
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  private

  def insert_recursive(node, value)
    return Node.new(value) if node.nil?

    if value < node.data
      node.left = insert_recursive(node.left, value)
    elsif value > node.data
      node.right = insert_recursive(node.right, value)
    end

    node
  end

  def find_recursive(node, value)
    return nil if node.nil?

    return node if node.data == value

    if value < node.data
      find_recursive(node.left, value)
    else
      find_recursive(node.right, value)
    end
  end

  def inorder_traversal(node, result, &block)
    return result if node.nil?

    inorder_traversal(node.left, result, &block)
    block_given? ? yield(node) : result << node.data
    inorder_traversal(node.right, result, &block)

    result
  end

  def preorder_traversal(node, result, &block)
    return result if node.nil?

    block_given? ? yield(node) : result << node.data
    preorder_traversal(node.left, result, &block)
    preorder_traversal(node.right, result, &block)

    result
  end

  def postorder_traversal(node, result, &block)
    return result if node.nil?

    postorder_traversal(node.left, result, &block)
    postorder_traversal(node.right, result, &block)
    block_given? ? yield(node) : result << node.data

    result
  end

  def height_recursive(node)
    return -1 if node.nil?

    left_height = height_recursive(node.left)
    right_height = height_recursive(node.right)

    [left_height, right_height].max + 1
  end

  def contains?(node)
    !find(node.data).nil?
  end
end
