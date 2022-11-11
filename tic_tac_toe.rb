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
    # array to track of places Xs and Os
    @place = Array.new(9) { |n| n + 1 }
  end

  def display_board
    puts "\n
          #{place[0]} | #{place[1]} | #{place[2]}\n
          - + - + -\n
          #{place[3]} | #{place[4]} | #{place[5]} \n
          - + - + -\n
          #{place[6]} | #{place[7]} | #{place[8]}"
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

grid = Grid.new
grid.display_board
