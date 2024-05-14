class Node
  include Comparable
  attr_accessor :data, :left, :right
  
  def initialize(value = nil)
    @data = value
    @left = nil
    @right = nil
  end
end


class Tree
  def initialize(arr)
    @root = build_tree(arr)
  end

  def build_tree(arr)
    clean_arr = arr.sort.uniq
    root = Node.new
    root = build_subtree(clean_arr)
  end

  def build_subtree(arr)
    #puts "Entering with #{arr}"
    mynode = Node.new
    if arr.length <= 1
      mynode = Node.new(arr[0])
      if mynode.data != nil
        return mynode
      else
        return nil
      end
    end
    arr_left = arr.slice!(0..(arr.length - 2) / 2)
    mynode.data = arr.shift
    arr_right = arr
    mynode.left = build_subtree(arr_left)
    mynode.right = build_subtree(arr_right)
    return mynode
  end

  def traverse_tree(value, node)
    # "#{value} #{node.data}"
    if value < node.data
      if node.left == nil || node.left.data == value
        return [node, "L"] 
      else
        # "Traversing with node"
        # node
        traverse_tree(value, node.left)
      end
    elsif value > node.data 
      if node.right == nil || node.right.data == value
        return [node, "R"]
      else
        traverse_tree(value, node.right)
      end
    else
      return [node, "D"]
    end
  end
  
  def insert(value)
    target_node = traverse_tree(value, @root)
    new_node = Node.new(value)
    case target_node[1]
    when "L"
      target_node[0].left = new_node
    when "R"
      target_node[0].right = new_node
    else
      target_node[0].data = new_node
    end
  end

  def delete(value)
    # "entering delete"
    node_to_delete = traverse_tree(value, @root)[0]

    if node_to_delete.left == nil && node_to_delete.right == nil
      # "case leaf"
      parent_node = traverse_tree(value, @root)
      case parent_node[1]
      when "L"
        parent_node[0].left = nil
      when "R"
        parent_node[0].right = nil
      else
        parent_node[0].data = nil
      end
    end

    if (node_to_delete.left != nil && node_to_delete.right == nil) || (node_to_delete.left == nil && node_to_delete.right != nil)
      # "case node with single child"
      parent_node = traverse_tree(value, @root)
      case parent_node[1]
      when "L"
        parent_node[0].left = node_to_delete.left
      when "R"
        parent_node[0].right = node_to_delete.right
      else
        parent_node[0].data = nil
      end
    end
      
    if (node_to_delete.left != nil && node_to_delete.right != nil)
      # "case node with children"
      target_node = traverse_tree(value + 1, @root)[0]
      if target_node.left != nil
        target_node = traverse_tree(value + 1, target_node.left)[0]
      end
      if target_node.right != nil
        target_node = traverse_tree(value + 1, target_node.right)[0]
      end
      delete(target_node.data)
      node_to_delete.data = target_node.data 
    end
  end
  
  def pretty_print(node = @root, prefix = '', is_left = true)
     pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
     puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
     pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def find(value)
    target_node = traverse_tree(value, @root)
    case target_node[1]
    when "L"
      target_node[0].left
    when "R"
      target_node[0].right
    else
      target_node[0]
    end
  end

  def level_order(&block)
    q = []
    q << @root
    while q.length > 0
      node = q.shift
      yield node if node.data != nil
      q << node.left if node.left != nil
      q << node.right if node.right != nil
    end
  end

  def preorder(&block)
     root_first(@root, &block)   
  end

  def inorder(&block)
     left_first(@root, &block)   
  end

  def postorder(&block)
     right_first(@root, &block)   
  end

  def root_first(node, &block)
    if node != nil
      yield node
      root_first(node.left, &block)
    end
    root_first(node.right, &block) if node != nil
  end

  def left_first(node, &block)
    if node != nil
      left_first(node.left, &block) if node.left != nil
      yield node
      left_first(node.right, &block) if node.right != nil
    end
  end
  
  def right_first(node, &block)
    if node != nil
      right_first(node.right, &block) if node.right != nil
      yield node
      right_first(node.left, &block) if node.left != nil
    end
  end

  def height(node = @root)
    @hmax = 0
    find_leaf(node, 0)
  end

  def find_leaf(node, h)
    #puts "#{@hmax} : #{h}"
    if node != nil
      if node.left != nil
        h += 1
        @hmax = h if h >= @hmax
        find_leaf(node.left, h) 
        h -= 1
      end
      if node.right != nil
        h += 1
        @hmax = h if h >= @hmax
        find_leaf(node.right, h) 
        h -= 1
      end
    end
    @hmax
  end

  def depth(value)
    @depth = -1
    @true_depth = nil
    find_node(value, @root)
  end

  def find_node(value, node)
    @depth += 1
    if @true_depth == nil
      puts "Node : #{node.data} Depth = #{@depth}"
      if node.data == value
        @true_depth = @depth
        return @depth
      else
        if node.left != nil
          find_node(value, node.left)
          @depth -= 1
        end
        if node.right != nil
          find_node(value, node.right) 
          @depth -= 1
        end
      end
    end
    @true_depth
  end

  def balanced?(node = @root)
    if node.left == nil && node.right == nil
      return true
    elsif node.left == nil  && node.right != nil
      if node.right.left != nil || node.right.right != nil
        return false 
      else
        return true
      end
    elsif node.right == nil  && node.left != nil
      if node.left.left != nil || node.left.right != nil    
        return false 
      else
        return true
      end
    elsif (height(node.left) - height(node.right)).between?(-1,1)
      balanced?(node.left)
      balanced?(node.right)
    else
      return false
    end
  end

  def rebalance
    new_arr = []
    preorder { |node| new_arr << node.data}
    build_tree(new_arr)
    new_arr
  end
end

#mytree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324, 72, 58, 2486, 01, 87, 59, 22, 63, 98])
#mytree.pretty_print

myrndtree = Tree.new((Array.new(20) { rand(1..100) }))
myrndtree.pretty_print

p myrndtree.balanced?
puts "=== LVLORDER ==="
myrndtree.level_order{ |node| print " > #{node.data}"}
puts "=== PREORDER ==="
myrndtree.preorder{ |node| print " > #{node.data}"}
puts "=== PREORDER ==="
myrndtree.inorder{ |node| print " > #{node.data}"}
puts "=== POSTORDER ==="
myrndtree.postorder{ |node| print " > #{node.data}"}

myrndtree.insert(131)
myrndtree.insert(152)
p myrndtree.balanced?
myrndtree.pretty_print
myrndtree.rebalance
p myrndtree.balanced?
myrndtree.pretty_print
