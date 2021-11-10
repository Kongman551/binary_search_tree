require_relative 'node.rb'
require_relative 'tree.rb'

puts "Binary Search Tree\n\n"

sleep 3

r = Tree.new((Array.new(15) { rand(1..100) }))
r.pretty_print
puts "\n\nIs tree balanced? #{r.balanced?}\n\n"

sleep 4

print "Level-Order: #{r.level_order}\n\n"
print "Pre-Order: #{r.preorder}\n\n"
print "Post-Order: #{r.postorder}\n\n"
print "In-Order: #{r.inorder}\n\n"
puts "Adding #'s 356, 700, 7324"
r.insert(356)
r.insert(700)
r.insert(7324)

sleep 4

print "\n\n"
r.pretty_print
puts "\n\nIs tree balanced? #{r.balanced?}\n\n"

sleep 4

puts "Rebalancing tree....\n"

sleep 3

r.rebalance
r.pretty_print
puts "\n\nIs tree balanced? #{r.balanced?}\n\n"

sleep 4

print "Level-Order: #{r.level_order}\n\n"
print "Pre-Order: #{r.preorder}\n\n"
print "Post-Order: #{r.postorder}\n\n"
print "In-Order: #{r.inorder}\n\n"