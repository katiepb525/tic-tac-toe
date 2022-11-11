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
end

# get name of first player
puts 'player 1, enter your name!'
p1_name = gets.chomp
puts 'enter your symbol:'
p1_symbol = gets.chomp
p1 = Player.new(p1_name, 'X')

# get name of second player
puts 'player 2, enter your name!'
p2_name = gets.chomp
p2 = Player.new(p2_name, 'O')
