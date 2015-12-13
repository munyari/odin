#!/usr/bin/env ruby
require 'set'

def knight_moves(start, goal)
  visited = Set.new
  q = []
  parent = Hash.new(-1)
  q << start
  visited.add(start)
  
  until q.empty?
    current = q.shift
    return reconstruct_path(parent, goal) if goal == current
    x = current[0]
    y = current[1]
    for i in (x-2)..(x+2) # a lot of unneccessary iterations here
      for j in (y-2)..(y+2)
        coords = [i,j]
        unless (i-x).abs + (j-y).abs == 3 && coords.all? { |x| x.between?(1,8) }# describes all valid moves
          next
        end
        next if visited.include?(coords)
        visited.add(coords)
        q << coords
        parent[coords] = current
      end
    end
  end
end

def reconstruct_path(parent_hash, destination)
  return [destination] if parent_hash[destination].equal?(-1)
  reconstruct_path(parent_hash, parent_hash[destination]) << destination
end

p knight_moves([1,1],[1,1])
p knight_moves([1,1],[1,2])
