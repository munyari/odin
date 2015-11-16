#!/usr/bin/env ruby
require "set"

def merge_sort(arr)
  return [] if arr.nil?
  return arr if arr.size <= 1

  middle = (arr.size) / 2
  left = merge_sort(arr[0...middle])
  right = merge_sort(arr[middle..-1])

  merge(left, right)
end

def merge(left, right)
  result = []
  i, j = 0, 0
  while i < left.size && j < right.size
    if (left[i] <= right[j])
      result << left[i]
      i += 1
    else
      result << right[j]
      j += 1
    end
  end

  left_rest = left[i..-1]
  right_rest = right[j..-1]
  result.concat(left_rest) unless left_rest.nil?
  result.concat(right_rest) unless right_rest.nil?
  result
end


def rand_n(n, max)
  randoms = Set.new
  loop do
    randoms << rand(max)
    return randoms.to_a if randoms.size >= n
  end
end

arr = rand_n(15, 1000)
p merge_sort(arr)
