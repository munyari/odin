module Mastermind
  class Game
    def initialize
      @player_board = []
      @mastermind = []
      @@COLORS = {BLACK:  "BLACK ", BLUE:   "BLUE  ",
                  BROWN:  "BROWN ", GREEN:  "GREEN ",
                  ORANGE: "ORANGE", RED:    "RED   ",
                  WHITE:  "WHITE ", YELLOW: "YELLOW"}
    end
  end

  class Player
    def initialize game
      @game = game
    end

  end
end

Mastermind::Game.new
