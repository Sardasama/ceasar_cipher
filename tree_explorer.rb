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
    puts "Entering with #{arr}"
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
    yield @root
    yield_recursive(@root.left, @root, &block)
    yield_recursive(@root.right, @root, &block)
  end

  def yield_recursive(node, parent_node, &block)
    yield node 
    yield_recursive(node.left, node, &block) if node.left != nil
    yield_recursive(node.right, node, &block) if node.right != nil
  end

end

mytree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324, 72, 58, 2486, 01, 87, 59, 22, 63, 98])
mytree.pretty_print

mytree.insert(12)
mytree.pretty_print

mytree.delete(58)
mytree.pretty_print

p mytree.find(67)

mytree.level_order{ |node| p node.data }
