# frozen_string_literal: true

require_relative 'board'

# It consists of states through which it check the state and update the states while players update the moves.
class State
  def initialize(board)
    @board = board
  end

  def wins(board, player) # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    win_state = []
    n = board.size - 1
    (0..n).each do |i|
      row = []
      (0..n).each do |j|
        row << board.cell_value(i, j)
      end
      win_state << row
      column = []
      (0..n).each do |j|
        column << board.cell_value(j, i)
      end
      win_state << column
    end
    diagonal1 = []
    (0..n).each do |i|
      (0..n).each do |j|
        diagonal1 << board.cell_value(i, j) if i == j
      end
    end
    win_state << diagonal1
    diagonal2 = []
    (0..n).each do |i|
      (0..n).each do |j|
        diagonal2 << board.cell_value(i, j) if i + j == n
      end
    end
    win_state << diagonal2

    win_state.include? Array.new(board.size, player)
  end

  def game_over?
    wins(@board, Player::PLAYER1) || wins(@board, Player::PLAYER2) || @board.empty_cells.empty?
  end

  def declare_result(board)
    if wins(board, Player::PLAYER1)
      puts "Player #{Player::PLAYER1} wins"
    elsif wins(board, Player::PLAYER2)
      puts "Player #{Player::PLAYER2} wins"
    else
      puts "It's a draw"
    end
  end
end
