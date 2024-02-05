# main.rb
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
    @state = State.new(@board)
    @player = Player.new
    @moves = Moves.new(@board)
  end

  def run_game
    @moves.loops_until_game_finished

    # Shows out the final state of the table
    @board.render(Player::PLAYER1, Player::PLAYER2)

    # Check the result
    result = @state.evaluate(@board)

    case result
    when 1
      puts "Player #{Player::PLAYER1} wins!"
    when -1
      puts "Player #{Player::PLAYER2} wins!"
    else
      puts "It's a draw!"
    end
  end
end


Main.new.run_game
