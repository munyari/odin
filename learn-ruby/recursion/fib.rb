#!/usr/bin/env ruby
require "matrix"

# simple recursion
def fib_rec(n)
  return n if n.between?(0, 1)
  return fib_rec(n - 1) + fib_rec(n - 2)
end

# simple iteration
def fib_iter(n)
  return n if n.between?(0, 1)
  ans = 0
  a = 0
  b = 1

  2.upto(n) do
    ans = a + b
    a = b
    b = ans
  end
  return ans
end

# memoized fibonacci - less efficient than iteration but nice to think about
def fib_mem(n)
  fib = Hash.new do |f, n|
    f[n] = if n <= 1
             n
           else
             f[n - 1] + f[n - 2]
           end
  end
  fib[n]
end

# personal favorite, matrix multiplication
def fib_matrix(n)
  (Matrix[[1,1],[1,0]] ** n)[1, 0]
end


