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
        unless ["y", "n", ""].include?(answer)
          raise ArgumentError, "Please enter either \"y\" or \"n\"" 
        end
      rescue ArgumentError=> e
        puts e
        retry
      end
      duplicates = "y" == answer
      puts "OK."
      begin
      puts "And how many balls should be in a row? (min: 3, max: 8)"
      @n = gets.chomp.to_i
      unless (3..8).include?(@n)
        raise ArgumentError, "Please enter a number between 3 and 8."
      end
      rescue ArgumentError=> e
        puts e
        puts "Let's try this again..."
        retry
      end

      @mastermind = generate_mm(duplicates)
      p @mastermind
      play
    end

    def play
       
    end

    private

    def generate_mm(duplicates=false)
      if duplicates
        result =[]
        @n.times { result << @@COLORS.sample } 
        result
      else
        @@COLORS.sample(@n)
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
