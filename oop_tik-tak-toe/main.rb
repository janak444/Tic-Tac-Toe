require_relative 'board'
require_relative 'state'
require_relative 'player'
require_relative 'moves'

class Main
  def initialize
    puts "Enter the size of the board"
    loop do
      @size = gets.chomp.to_i
      if @size < 3 || @size > 10
        puts "please enter the size between 3 and 10"
      end

      break if @size > 2 && @size < 11
    end
    @board = Board.new(@size)
    @moves = Moves.new(@board)
  end

  def run_game
    @moves.loop_until_game_finished
    @board.render(Player::PLAYER1, Player::PLAYER2) 
  end
end
Main.new.run_game
