module Enumerable
  def my_each
    return self unless block_given?
    for i in self
      yield(i)
    end
  end

  def my_each_with_index
    return self unless block_given?
    0.upto(self.length-1) { |i| yield(self[i], i) }
  end

  def my_select
    return self unless block_given?

  end

  def my_all?

  end

  def my_any?

  end

  def my_none?

  end

  def my_count

  end

  def my_map

  end

  def my_inject

  end
end

test_arr = [1, 2, 3, 4]
test_arr.my_each { |x| puts x }
test_arr.my_each_with_index { |x, i| puts "#{i}: #{x}" }
