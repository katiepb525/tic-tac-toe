# frozen_string_literal: true

# class that creates player instance
class Player
  def initialize(name, symbol)
    # whats the player's name?
    @name = name
    # are they using 'X' or 'O'?
    @symbol = symbol
  end
end

# class that creates grid instance
class Grid
  def initialize
    # grid to be displayed
    @display_grid = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    # grid to keep track of Xs and Os
    @curr_game = [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]
  end
end

# class that creates instance of a new game
class NewGame
  def initialize(player1, player2, game_grid)
    @player1 = player1
    @player2 = player2
    @game_grid = game_grid
  end
end
