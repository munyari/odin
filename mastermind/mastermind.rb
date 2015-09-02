module Mastermind
  class Game
    def initialize
      @@COLORS = ["BLACK ", "BLUE  ",
                  "BROWN ", "GREEN ",
                  "ORANGE", "RED   ",
                  "WHITE ", "YELLOW"]
      @player_board = []
      puts "Hey there! Welcome to Mastermind. Just a few settings before we begin."
      begin
        puts "Would you like to allow duplicate colors? (y/N)"
        answer = gets.chomp.downcase
        unless ["y", "n"].include?(answer)
          raise ArgumentError, "Please enter either \"y\" or \"n\"" 
        end
      rescue ArgumentError=> e
        puts e
        retry
      end
      duplicates = answer == "y"
      puts "OK. And how many balls should be in a row? (min: 3, max: 8)"
      balls = [3, [gets.chomp.to_i, 8].min].max
      @mastermind = generate_mm(duplicates, balls)
      p @mastermind
      play
    end

    def play

    end

    private

    def generate_mm(duplicates=false, n)
      if duplicates
        result =[]
        n.times { result << @@COLORS.sample } 
        result
      else
        @@COLORS.sample(n)
      end
    end
  end

  class Player
    def initialize game
      @game = game
    end

  end
end

Mastermind::Game.new
