#!/usr/bin/env ruby

def caesar_cipher(str, shift)
  unless str.is_a?(String) && shift.is_a?(Fixnum)
    raise ArgumentError, "Argument is invalid"
  end
  shift = shift % 26
  s_arr = str.chars
  s_arr.collect! do |c|
    ascii = c.ord
    if uppercase?(ascii)
      c = new_char(ascii, shift, :uppercase)
    elsif lowercase?(ascii)
      c = new_char(ascii, shift, :lowercase)
    else
      c
    end
  end
  s_arr.join
end

def new_char(c, shift, l_case)
  if l_case == :uppercase
    low = 65
    high = 90
  elsif l_case == :lowercase
    low = 97
    high = 122
  end

  if c + shift > high
    (((c + shift) % high) + low - 1).chr
  else
    (c + shift).chr
  end
end

def uppercase?(c)
  c.between?(65, 90)
end

def lowercase?(c)
  c.between?(97, 122)
end
