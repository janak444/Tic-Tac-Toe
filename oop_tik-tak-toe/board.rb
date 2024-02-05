class Board
  attr_reader:size

  def initialize(size)
    @size = size
    @board = Array.new(@size) { Array.new(@size) }
  end
  def cell_value(x,y)
    @board[x][y]
  end

  def render(player1_choice, player2_choice)
    @board.each_with_index do |row, x|
      puts "\n-----------------------------------------------------------------------------"
      row.each_with_index do |cell, y|
        if cell == Player::PLAYER1
          print "| #{player1_choice} |"
        elsif cell == Player::PLAYER2
          print "| #{player2_choice} |"
        else
          print "| #{x} #{y}  |"
        end
      end
    end
    puts "\n----------------------------------------------------------------------------"
  end

  def set_move(x, y, player)
    if empty_cells.include?([x, y, "#{x}#{y}"])
      @board[x][y] = player
      return true
    end
    false
  end
  
  def empty_cells
    @board.each_with_index.flat_map do |row, x|
      row.each_with_index.map { |cell, y| [x, y, "#{x}#{y}"] if cell.nil?}
    end.compact
  end
end


