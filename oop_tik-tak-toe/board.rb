# frozen_string_literal: true

# board class use to do initialize the board, check the board state and render the board in cmd
class Board
  attr_reader :size

  def initialize(size)
    @size = size
    @board = Array.new(@size) { Array.new(@size) }
  end

  def cell_value(x_row, y_column)
    @board[x_row][y_column]
  end

  def render(p1_choice, p2_choice)
    @board.each_with_index do |row, x|
      puts "\n......................................................................................"
      row.each_with_index do |cell, y|
        print(if cell == Player::PLAYER1
                "| #{p1_choice} |"
              else
                (cell == Player::PLAYER2 ? "| #{p2_choice} |" : "| #{x} #{y} |")
              end)
      end
    end
    puts "\n......................................................................................"
  end

  def set_move(x_row, y_column, player)
    if empty_cells.include?([x_row, y_column, "#{x_row}#{y_column}"])
      @board[x_row][y_column] = player
      return true
    end
    false
  end

  def empty_cells
    @board.each_with_index.flat_map do |row, x|
      row.each_with_index.map { |cell, y| [x, y, "#{x}#{y}"] if cell.nil? }
    end.compact
  end
end
