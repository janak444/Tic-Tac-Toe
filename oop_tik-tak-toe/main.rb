# frozen_string_literal: true

require_relative 'board'
require_relative 'state'
require_relative 'player'
require_relative 'moves'

# main class runs the program, it consist of all the dependencies and call all the classes to run.
class Main
  def initialize
    # puts 'Enter the size of the board'
    # loop do
    #   @size = gets.chomp.to_i
    #   puts 'please enter the size between 3 and 10' if @size < 3 || @size > 10

    #   break if @size > 2 && @size < 11
    # end
    @size = 3
    @board = Board.new(@size)
    @moves = Moves.new(@board)
  end

  def run_game
    @moves.loop_until_game_finished
    @board.render(Player::PLAYER1, Player::PLAYER2)
  end
end
Main.new.run_game
