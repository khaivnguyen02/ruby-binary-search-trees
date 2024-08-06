# frozen_string_literal: true

require_relative 'lib/tree'

random_array = Array.new(15) { rand(1..100) }
bst = Tree.new(random_array)

puts "Initial array: #{random_array}"
puts "Tree is balanced? #{bst.balanced?}"
puts "Level-order: #{bst.level_order}"
puts "Pre-order: #{bst.preorder}"
puts "In-order: #{bst.inorder}"
puts "Post-order: #{bst.postorder}"

[101, 102, 103, 104, 105].each { |num| bst.insert(num) }

puts "\nAfter inserting several elements > 100"
puts "Tree is balanced? #{bst.balanced?}"

# Rebalance the tree
bst.rebalance

puts "\nAfter rebalancing"
puts "Tree is balanced? #{bst.balanced?}"
puts "Level-order: #{bst.level_order}"
puts "Pre-order: #{bst.preorder}"
puts "In-order: #{bst.inorder}"
puts "Post-order: #{bst.postorder}"
