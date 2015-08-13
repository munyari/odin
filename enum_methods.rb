# S/o to stackoverflow for helping me see how to return an enumerator object
# http://bit.ly/1NbaMwD

module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?
    for i in self
      yield(i)
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?
    0.upto(self.length-1) { |i| yield(self[i], i) }
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?
    result = []
    self.my_each { |i| result << i if yield(i) }
    result
  end

  def my_all?
    return true unless block_given?
    self.my_each { |i| return false unless yield(i) }
    true
  end

  def my_any?
    return true unless block_given?
    self.my_each { |i| return true if yield(i) }
    false
  end

  def my_none?
    !my_any? { |i| yield(i) }
  end

  def my_count(param=nil)
    count = 0
    if param
      self.my_each { |i| count += 1 if i == param }
      count
    elsif block_given?
      self.my_each { |i| count += 1 if yield(i) }
      count
    else
      self.size
    end
  end

  def my_map(p)
    result = []
    self.my_each { |i| result << p.call(i) }
    result
  end

  def my_inject(memo=nil)
    unless memo
      memo = self[0]
      start = 1
    else
      start = 0
    end
    start.upto(self.size - 1) { |i| memo = yield(memo, self[i]) }
    memo
  end

end


def multiply_els arr
  return arr.my_inject { |m, k| k * m }
end
