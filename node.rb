class Node
    #include Comparable
    attr_accessor :l_child, :r_child, :data
    
        def initialize(d)
            @data = d
            @l_child = nil
            @r_child = nil
        end
    end