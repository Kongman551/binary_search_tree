class Tree
    attr_accessor :root, :arr, :size
    
        def initialize(array)
            @arr = array.uniq.sort
            @root = build_tree(arr)
        end
    
        def build_tree(array)
            return nil if array.empty?
            
            array = array.uniq.sort
            mid = (array.size - 1) / 2
            root_node = Node.new(array[mid])
            root_node.l_child = build_tree(array[0...mid])
            root_node.r_child = build_tree(array[(mid + 1)..-1])
            root_node
        end
    
        def insert(key, node = root)
            #nil if key already exists
            return nil if key == node.data
    
            if key < node.data
                #create new node if left child is empty, else recur down left child
                node.l_child.nil? ? node.l_child = Node.new(key) : insert(key, node.l_child)
            else
                #create new node if right child is empty, else recur down right child
                node.r_child.nil? ? node.r_child = Node.new(key) : insert(key, node.r_child)
            end
        end
    
        def delete(key, node = root)
            delete_helper(key, node = root)
            node
        end
    
        def find(key, node = root)
            return false if node.nil?
            
            return true if key == node.data

            key < node.data ? find(key, node.l_child) : find(key, node.r_child)
        end
    
        def level_order(node = root)
            result = []
            return result if node.nil?
    
            queue = [node]
    
            until queue.empty?
                level_size = queue.length
                level = []
                level_size.times do 
                    next_node = queue.shift 
                    level << next_node.data
                    queue << next_node.l_child unless next_node.l_child.nil?
                    queue << next_node.r_child unless next_node.r_child.nil?
                end
                result << level
            end
            result.flatten
        end

        def preorder(node = root, array = [])
            unless node.nil?
                array << node.data
                preorder(node.l_child, array)
                preorder(node.r_child, array)
            end
            array
        end

        def inorder(node = root, array = [])
            unless node.nil?
                inorder(node.l_child, array)
                array << node.data
                inorder(node.r_child, array)
            end
            array
        end

        def postorder(node = root, array = [])
            unless node.nil?
                postorder(node.l_child, array)
                postorder(node.r_child, array)
                array << node.data
            end
            array
        end

        def get_max(node = root)
            return nil if node.nil?

            return node if node.r_child.nil?

            get_max(node.r_child)
        end

        def get_min(node = root)
            return nil if node.nil?

            return node if node.l_child.nil?

            get_min(node.l_child)
        end

        def height(node = root)
            return 0 if node.nil?

            l = node.l_child ? height(node.l_child) : 0
            r = node.r_child ? height(node.r_child) : 0

            l < r ? r + 1 : l + 1
        end

        def depth(key, node = root, count = 0)
            return nil if node.nil?

            if self.find(key, node)
                if key < node.data
                    count += 1
                    depth(key, node.l_child, count)  
                elsif key > node.data
                    count += 1
                    depth(key, node.r_child, count)
                else 
                    count += 1
                    return count
                end
            else 
                return nil
            end
        end

        def balanced?(node = root)
            return true if node.nil?

            return true if balanced?(node.l_child) &&
                           balanced?(node.r_child) &&
                           (height(node.l_child) - height(node.r_child)).abs <= 1

            false               
        end

        def rebalance
            @root = build_tree(level_order)
        end
    
        def pretty_print(node = root, prefix = '', is_left = true)
            pretty_print(node.r_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.r_child

            puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"

            pretty_print(node.l_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.l_child
        end   
        
        private

        def delete_helper(key, node = root)
            return nil if node.nil?

            if key < node.data
                #if key is less than node value move left
                node.l_child = delete_helper(key, node.l_child)
            elsif key > node.data
                #else if key is greater than node value  move right
                node.r_child = delete_helper(key, node.r_child)
            else
                if node.l_child != nil && node.r_child != nil
                    #temp_node = node
                    min_of_r_tree = get_min(node.r_child)
                    node.data = min_of_r_tree.data
                    node.r_child = delete_helper(min_of_r_tree.data, node.r_child)
                elsif node.l_child != nil
                    node = node.l_child
                elsif node.r_child != nil
                    node = node.r_child
                else
                    node = nil
                end
            end
            node
        end
    
    end