#== Hangman
# A playable hangman game

require 'set'
require 'yaml'

module Hangman
  # Game class defines the template for a game
  class Game
    attr_reader :word, :word_chars, :guessed_chars, :wrong_chars

    def initialize
      @@DICT = File.open("5desk.txt", "r").readlines
      # save path
      @@SAVE = "save.yaml"
      loop do
        @word = @@DICT.sample.chomp
        break if @word.length >= 5 && @word.length <= 12
      end
      @word_chars = Set.new(@word.chars)
      @guessed_chars = Set.new
      @wrong_chars = Set.new
      @total_guess = 0
      play
    end

    private

    # draws the current state of the game
    def draw
      puts
      @word.each_char do |c|
        unless @guessed_chars.include?(c)
          print "_"
        else
          print c
        end
      end
    end

    # validates player's move
    def valid_move?(char)
      char.length == 1 && 
        (char.downcase.between?("a", "z") || (0..1).include?(char.to_i))
    end

    # checks whether or not the game is complete
    def complete?
      @guessed_chars == @word_chars
    end


    # method that controls the game loop
    def play
      puts "Hello there, welcome to Hangman!"
      puts "Here are the rules: I've selected a word of length #{@word.length}"
      puts "You have fifteen guesses to guess all the characters of this word."
      begin
        @total_guesses = @guessed_chars.length + @wrong_chars.length
        draw
        make_move
      end until @total_guesses == 14 || complete?
      if complete?
        draw
        puts "\nCongrats! You win! You bloody genius!"
      else
        puts "Aww, tough luck mate :( \nWanna try again?"
        puts "The word was #{@word} by the way"
      end
    end


    # make a move by prompting the player
    def make_move
      puts "\n\nYou have #{15-@total_guesses} move(s) left"
      puts "You've guessed these characters wrong:"
      draw_wrong_chars
      puts "Select a character, a-z"
      puts "You can also save [0] the current game or load [1] a save file"
      move = gets.chomp.downcase
      until valid_move?(move)
        puts "Sorry, that is not a valid move. Please enter a single 
        alphabetical character"
        move = gets.chomp.downcase
      end
      if move == "0"
        save_game
      elsif move == "1"
        load_game
      elsif move.between?("a", "z")
        if @word_chars.include?(move.downcase) 
          @guessed_chars.add(move.downcase)
        elsif @word_chars.include?(move.upcase)
          @guessed_chars.add(move.upcase)
        else
          @wrong_chars.add(move.downcase)
        end
      end
    end

    # print the characters that the player has gotten wrong
    def draw_wrong_chars
      puts @wrong_chars.to_a().map(&:upcase).join(", ")
    end

    # save the current game to file
    def save_game
      yaml = YAML::dump(self)
      File.open(@@SAVE, 'w') do |f|
        f.puts yaml
      end
    end

    # read saved data
    def load_game
      unless File.exists?(@@SAVE)
        puts "Sorry, there is no save file. Try saving a game first."
      else
        puts "Loading..."
        yaml = ''
        f = File.open(@@SAVE, 'r')
        f.each_line do |line|
          yaml += line
        end
        saved_game = YAML::load(yaml)
        @word = saved_game.word
        @word_chars = saved_game.word_chars
        @guessed_chars = saved_game.guessed_chars
        @wrong_chars = saved_game.wrong_chars
      end
    end
  end
end

Hangman::Game.new
