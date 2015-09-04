module Mastermind
  class Game
    def initialize
      @@COLORS = {BLACK:  "BLACK ", BLUE:   "BLUE  ",
                  BROWN:  "BROWN ", GREEN:  "GREEN ",
                  ORANGE: "ORANGE", RED:    "RED   ",
                  WHITE:  "WHITE ", YELLOW: "YELLOW"}
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

      puts "\nAwesome! Now we can get started!\n\n"
      @mastermind = generate_mm(duplicates)
      play
    end

    private
    def colors
      @@COLORS.values.map(&:strip).join(', ')
    end

    def play
      turns = 10
      @user_plays = []
      puts "The playable colors are #{colors}\n\n"
      begin
        puts "#{turns} turns left"
        puts "Enter your #{@n} colors\n\n"
        begin
          user_colors = gets.chomp.split.map(&:upcase).map(&:to_sym)
          unless valid_move(user_colors)
            raise ArgumentError, "Please restrict your moves to one of the colors 
            #{colors} and put #{@n} pegs on the board."
          end
        rescue ArgumentError => e
          puts e
          retry
        end
        @user_plays << user_colors
        break if user_colors == @mastermind
        turns -= 1
        draw
        hint_pegs(user_colors)
      end until turns == 0

      unless turns == 0
        puts "Congrats, you guessed right! You win!"
      else
        puts "You ran out of moves! You lose!"
      end
    end

    def hint_pegs(play)
      puts "Your hint pegs"
      result = []
      play.each_with_index do |color, i|
        if color == @mastermind[i]
          result << :BLACK
        elsif @mastermind.include?(color)
          result << :WHITE
        end
      end
      result.sort.each { |peg| print "#{@@COLORS[peg] } " }
      puts "\n\n"
    end

    def draw
      puts "\nYour game board\n"
      @user_plays.reverse_each do |play|
        play.each { |color| print "#{@@COLORS[color]} " } # also want to put a number here
        puts "\n"
      end
      puts "\n"
    end

    def valid_move(play)
      return false unless play.size == @n
      play.each { |color| return false unless @@COLORS.include?(color) }
      true
    end

    def generate_mm(duplicates=false)
      if duplicates
        result =[]
        @n.times { result << @@COLORS.keys.sample } 
        result
      else
        @@COLORS.keys.sample(@n)
      end
    end

  end

end

Mastermind::Game.new
