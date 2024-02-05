class Moves
  def initialize(board)
    @board = board
    @state = State.new(@board)
  end

  def player_turn(player)
    puts "Player #{player} (#{player}), enter your move (row and column separated by a space):"
    print "> "
    move = gets.chomp.split.map(&:to_i)

    if @board.set_move(move[0], move[1], player)
      puts "Move accepted!"
    else
      puts "Invalid move. Try again."
      player_turn(player)
    end
  end

  def loop_until_game_finished
    until @state.is_game_over?
      @board.render(Player::PLAYER1, Player::PLAYER2)

      player_turn(Player::PLAYER1)

      @board.render(Player::PLAYER1, Player::PLAYER2)
     if @state.is_game_over?
        @state.declare_result(@board)
        break
     end

      player_turn(Player::PLAYER2)
    end
  end
end
