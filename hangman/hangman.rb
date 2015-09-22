#== Hangman
# A playable hangman game
module Hangman
  # Game class defines the template for a game
  class Game
    def initialize
      @@DICT = File.open("5desk.txt", "r").readlines
    end

    private

    # draws the current state of the hangman
    def draw
    end

    # validates player's move
    def valid_move?(char)
    end

    # checks whether or not the game is complete
    def complete?
    end

    # check if we have a winner
    def check_win
    end

    # method that controls the game loop
    def play(p1, p2)
    end
  end

  # a hangman player
  class Player
    # create a new player
    def initialize(game, sym)
    end


    # make a move by prompting the player
    def make_move
    end
  end

end

Hangman::Game.new
