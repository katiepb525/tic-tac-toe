# frozen_string_literal: true

require 'pry-byebug'

# class that creates player instance
class Player
  attr_reader :name, :symbol

  def initialize(name, symbol)
    # whats the player's name?
    @name = name
    # are they using 'X' or 'O'?
    @symbol = symbol
  end
end

# class that creates grid instance
class Grid
  attr_accessor :place

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
  def initialize(player1, player2, grid)
    @player1 = player1
    @player2 = player2
    @grid = grid
    @game_end = false
  end

  # play a whole game
  def play_game
    puts 'game start!'

    # loop until win or tie condition is met. if condition is met, announce result.

    until @game_end == true
      play_round(@player1)
      player_won?(@player1)
      tie?
      break if @game_end == true

      play_round(@player2)
      player_won?(@player2)
      tie?

    end
  end

  # if player won row, column, or diag..
  def player_won?(current_player)
    return unless won_row?(current_player) == true || won_column?(current_player) == true

    puts "#{current_player.name} won!"
    puts 'end game!'
    @game_end = true
  end

  # play a single round
  def play_round(current_player)
    puts "#{current_player.name}, it's your turn! place your symbol.."
    @grid.display_board
    choice = (gets.chomp.to_i - 1)

    # check if chosen spot is already taken
    if @grid.place[choice] == 'X' || @grid.place[choice] == 'O'
      # loop until choice is NOT X AND is NOT O
      until @grid.place[choice] != 'X' && @grid.place[choice] != 'O'
        puts 'pick an available spot please!'
        choice = (gets.chomp.to_i - 1)
      end
    end
    update_square(choice, current_player)

    @grid.display_board
  end

  # check if current player won ROW after placing their symbol
  def won_row?(current_player)
    if @grid.place[0..2].all? { |place| place == current_player.symbol }
      true
    elsif @grid.place[3..5].all? { |place| place == current_player.symbol }
      true
    elsif @grid.place[6..9].all? { |place| place == current_player.symbol }
      true
    else
      false
    end
  end

  # check if current player won COLUMN after placing their symbol
  def won_column?(current_player)
    binding.pry
    row1 = [@grid.place[0], @grid.place[3], @grid.place[6]]
    row2 = [@grid.place[1], @grid.place[4], @grid.place[7]]
    row3 = [@grid.place[2], @grid.place[5], @grid.place[8]]
    if row1.all? { |place| place == current_player.symbol }
      true
    elsif row2.all? { |place| place == current_player.symbol }
      true
    elsif row3.all? { |place| place == current_player.symbol }
      true
    end
  end

  # check if current player won DIAGNOAL after placing their symbol
  def won_diag?(current_player)
    diag1 = [@grid.place[0], @grid.place[4], @grid.place[8]]
    diag2 = [@grid.place[6], @grid.place[4], @grid.place[2]]
    if diag1.all? { |place| place == current_player.symbol }
      true
    elsif diag2.all? { |place| place == current_player.symbol }
      true
    end
  end

  # check if all places are filled with a symbol (to declare a tie)
  def tie?
    return unless @grid.place.all? { |place| %w[X O].include?(place) }

    puts 'it was a tie!'
    @game_end = true
  end

  # pick a square with the current player's choice
  def update_square(choice, current_player)
    @grid.place[choice] = current_player.symbol
  end
end

# get name of first player
puts 'player 1, enter your name! youll be X...'
p1_name = gets.chomp
p1 = Player.new(p1_name, 'X')

# get name of second player
puts 'player 2, enter your name! youll be O...'
p2_name = 'dan'
p2 = Player.new(p2_name, 'O')

grid = Grid.new

game = NewGame.new(p1, p2, grid)
game.play_game
