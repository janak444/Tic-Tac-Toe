# Define player markers
PLAYER1 = 'X'||'x'
PLAYER2 = 'O'||'o'

#Choice of size of the board
puts "Enter the size of the board"
loop do
  $size = gets.chomp.to_i
  if $size<3 || $size>10
    puts "please enter the size between 3 and 10"
  end
  
  break if $size>2 && $size<11
end

#Defining the board
@board = Array.new($size){Array.new($size)}

#Check whether the state is empty or not?
def empty_cells(state)
    state.each_with_index.flat_map do |row, x|
      row.each_with_index.map { |cell, y| [x, y,"#{x}#{y}"] if cell.nil? || cell == 0 }
    end.compact
end

#check the state, if it is empty then player can enter the x or o
def set_move(x, y, player)
        if empty_cells(@board).include? [x, y,"#{x}#{y}"]
            @board[x][y] = player
            return true
        end
    false
end

# To make a 3x3 board
def render(state, player1_choice, player2_choice)
    state.each_with_index do |row, x|
      puts "\n-----------------------------------------------------------------------------"
      row.each_with_index do |cell, y|
        if cell == PLAYER1
          print "| #{player1_choice} |"
        elsif cell == PLAYER2
          print "| #{player2_choice} |"
        else
          print "| #{x} #{y}  |"
        end
      end
    end
    puts "\n----------------------------------------------------------------------------"
end

#Evaluate moves
def evaluate(state)
    if wins(state, PLAYER1)
      1
    elsif wins(state, PLAYER2)
      -1
    else
      0
    end
end

#Winning states define, to evaluate who win the games
def wins(state, player)
    win_state = []
      n = $size-1
      for i in 0..n
        row =[]
        for j in 0..n
          row << state[i][j]
        end
      win_state << row
      end
      for i in 0..n
        column = []
        for j in 0..n
          column << state[j][i]
        end
        win_state << column
      end
      diagonal1 =[]
      for i in 0..n
        for j in 0..n
          if i==j
           diagonal1 << state[i][j]  
          end
        end
      end
      win_state << diagonal1
      diagonal2 = []
      for i in 0..n
        for j in 0..n
          if i+j==n
          diagonal2 << state[i][j]
          end  
        end
      end
      win_state << diagonal2
  
    win_state.include?Array.new($size,player)
end

#Game hault conditions
def game_over(state)
    wins(state, PLAYER1) || wins(state, PLAYER2) || empty_cells(state).empty?
end

#Defining the players turn method to solve the problem
def player_turn(player)
    puts "Player #{player} (#{player}), enter your move (row and column separated by a space):"
    print "> "
    move = gets.chomp.split.map(&:to_i)
  
    if set_move(move[0], move[1], player)
      puts "Move accepted!"
    else
      puts "Invalid move. Try again."
      player_turn(player)
    end
  end

# Introduce a loop until the game is finished
until game_over(@board)
    render(@board, PLAYER1, PLAYER2)
  
    player_turn(PLAYER1)
  
    render(@board, PLAYER1, PLAYER2)
    break if game_over(@board)
  
    player_turn(PLAYER2)
end

#Shows out the final state of the table
render(@board, PLAYER1, PLAYER2)

# Check the result
result = evaluate(@board)

case result
when 1
  puts "Player #{PLAYER1} wins!"
when -1
  puts "Player #{PLAYER2} wins!"
else
  puts "It's a draw!"
end

