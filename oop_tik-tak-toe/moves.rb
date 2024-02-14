# frozen_string_literal: true

# moves class call the board and state class, check the state of the board anf runs until the results of the game occur.
class Moves
  def initialize(board)
    @board = board
    @state = State.new(@board)
  end

  def player_turn(player)
    puts "Player #{player} (#{player}), enter your move from 1 to 9 :"
    print '> '
    # move = gets.chomp.split.map(&:to_i)
    # static
    # case move[0]
    # when 1
    #   move[0] = 0
    #   move[1] = 0
    # when 2
    #   move[0] = 0
    #   move[1] = 1
    # when 3
    #   move[0] = 0
    #   move[1] = 2
    # when 4
    #   move[0] = 1
    #   move[1] = 0
    # when 5
    #   move[0] = 1
    #   move[1] = 1
    # when 6
    #   move[0] = 1
    #   move[1] = 2
    # when 7
    #   move[0] = 2
    #   move[1] = 0
    # when 8
    #   move[0] = 2
    #   move[1] = 1
    # when 9
    #   move[0] = 2
    #   move[1] = 2
    # end

    # use hash map to shorten the code
    # move_map = {
    #   1 => [0, 0],
    #   2 => [0, 1],
    #   3 => [0, 2],
    #   4 => [1, 0],
    #   5 => [1, 1],
    #   6 => [1, 2],
    #   7 => [2, 0],
    #   8 => [2, 1],
    #   9 => [2, 2]
    # }

    # dynamic hash function
    move_map = Hash.new { |has, key| has[key] = [] }
    board_size = @board.size
    key = 1
    (0...board_size).each do |x_row|
      (0...board_size).each do |y_column|
        move_map[key] << x_row
        move_map[key] << y_column
        key += 1
      end
    end

    move = gets.chomp.split.map(&:to_i)
    move[0], move[1] = move_map[move[0]]

    if @board.set_move(move[0], move[1], player)
      puts 'Move accepted!'
    else
      puts 'Invalid move. Try again.'
      player_turn(player)
    end
  end

  def loop_until_game_finished
    until @state.game_over?

      @board.render(Player::PLAYER1, Player::PLAYER2)
      player_turn(Player::PLAYER1)

      @board.render(Player::PLAYER1, Player::PLAYER2)
      if @state.game_over?
        @state.declare_result(@board)
        break
      end
      player_turn(Player::PLAYER2)
      if @state.game_over?
        @state.declare_result(@board)
        break
      end
    end
  end
end
