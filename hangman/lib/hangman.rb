#== Hangman
# A playable hangman game

require 'set'
require 'yaml'

module Hangman
  # Game class defines the template for a game
  class Game
    # do I need accessor methods?
    attr_accessor :word, :word_chars, :guessed_chars, :wrong_chars

    @@HANGMAN = <<-END.gsub(/^ {4}/, '')
        ___________.._______
    | .__________))______|
    | | / /      ||
    | |/ /       ||
    | | /        ||.-''.
    | |/         |/  _  \
    | |          ||  `/,|
    | |          (\\`_.'
    | |         .-`--'.
    | |        /Y . . Y\
    | |       // |   | \\
    | |      //  | . |  \\
    | |     ')   |   |   (`
    | |          ||'||
    | |          || ||
    | |          || ||
    | |          || ||
    | |         / | | \
    """"""""""|_`-' `-' |"""|
    |"|"""""""\ \       '"|"|
    | |        \ \        | |
    : :         \ \       : :
    . .          `'       . .
    END


    def initialize
      @@DICT = File.open("5desk.txt", "r").readlines
      # save path
      @@SAVE = "save.yaml"
      #@@SAVE = File.exists?("save.yaml") ? File.open("save.yaml", "r+") :
      #File.open("save.yaml", "w")
      loop do
        @word = @@DICT.sample.chomp
        break if @word.length >= 5 && @word.length <= 12
      end
      @word_chars = Set.new(@word.chars)
      @guessed_chars = Set.new
      @wrong_chars = Set.new
      play
    end

    private

    # draws the current state of the hangman
    def draw
      @word.each_char do |c|
        unless @guessed_chars.include?(c)
          print "_"
        else
          print c
        end
      end
      puts
    end

    # validates player's move
    def valid_move?(char)
      char.length == 1 && char.downcase.between?("a", "z")
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
      puts @word
      guesses = 0
      begin
        draw
        make_move
        guesses += 1 
      end until guesses == 15 || complete?
      if complete?
        draw
        puts "Congrats! You win! You bloody genius!"
      else
        puts "Aww, tough luck mate :( \nWanna try again?"
      end
    end


    # make a move by prompting the player
    def make_move
      puts "\nSelect a character, a-z"
      move = gets.chomp.downcase
      until valid_move?(move)
        puts "Sorry, that is not a valid move. Please enter a single 
        alphabetical character"
        move = gets.chomp.downcase
      end
      #if move.between?("a", "z")
      if @word_chars.include?(move.downcase) 
        @guessed_chars.add(move.downcase)
      end
      if @word_chars.include?(move.upcase)
        @guessed_chars.add(move.upcase)
      end
    end

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
        yaml = ''
        f = File.open(@@SAVE, 'r')
        f.each_line do |line|
          yaml += line
        end
        YAML::load(yaml)
      end
    end
  end
end

Hangman::Game.new
