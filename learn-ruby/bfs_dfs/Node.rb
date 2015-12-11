#!/usr/bin/env ruby

require 'set'

class Node
  attr_accessor :value, :left, :right

  def initialize(*args)
    # let's have some exception handling mate!
    @value = args[0]
    @left = args[1]   # may be null
    @right = args[2]  # may be null
  end

  def get_left
    return nil if @left.nil?
    return @left.value
  end

  def get_right
    return nil if @right.nil?
    return @right.value
  end

  def set_left(n)
    if @left.nil?
      @left = Node.new(n)
    else
      @left.value = n
    end
  end

  def set_right(n)
    if @right.nil?
      @right = Node.new(n)
    else
      @right.value = n
    end
  end

  def insert(n)
    if @value.nil?
      @value = n
    elsif n <= @value
      unless @left.nil?
        @left.insert(n)
      else
        @left = Node.new(n)
      end
    else
      unless @right.nil?
        @right.insert(n)
      else
        @right = Node.new(n)
      end
    end
  end

  def to_s
    # inorder traversal
    s = ""
    s += "#{@left} " unless @left.nil?
    s += "#{@value} "
    s += "#{@right} " unless @right.nil?
    s
  end
end

def build_tree(arr)
  tree = Node.new
  arr.each { |n| tree.insert(n) }
  return tree
end

def breadth_first_search(tree, n)
  return nil if tree.nil?
  q = []
  q << tree
  until q.empty?
    curr = q.shift
    return curr if curr.value == n
    q << curr.left unless curr.left.nil?
    q << curr.right unless curr.right.nil?
  end
  return nil
end

def depth_first_search(tree, n)
  return nil if tree.nil?
  st = []
  st << tree
  until st.empty?
    curr = st.pop
    return curr if curr.value == n
    st << curr.left unless curr.left.nil?
    st << curr.right unless curr.right.nil?
  end
  return nil
end

def dfs_rec(tree, n)
  return nil if tree.nil?
  return tree if tree.value == n
  dfs_rec(tree.left)
  dfs_rec(tree.right)
end

puts dfs_rec(build_tree([1, 7, 4, 23, 8, 9, 4]), 23)
