def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  return input.to_i - 1
end

def move(board, pos, player)
  board[pos] = player
  display_board(board)
end

def position_taken?(board, index)
  if valid_move?(board, index) #if true, then index is not taken.
    return false
  else
    return true
  end
end

def valid_move?(board, index)
  if !index.between?(0,8) || 
     board[index] == nil || 
     board[index] == "X" || 
     board[index] == "O"
    return false #if no input
  else
    return true
  end
end

def turn(board)
  request_num = "Please enter 1-9:"
  valid_response = false
  while valid_response == false do
    puts request_num
    input = gets.strip
    index = input_to_index(input)
    if !position_taken?(board, index)
      valid_response = true
      move(board, index, current_player(board))
    else
      valid_response = false
    end
  end
end

def turn_count(board)
  count = 0
  board.each do |space|
  	space.include?("X")||space.include?("O") ? count += 1 : count 
  end
  return count
end #end turn_count

def current_player(board)
  player1 = "X"
  player2 = "O"
  turn_count(board).even? ? player1 : player2
end

def play(board)
  turn(board)
  
 
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2],[3,4,5],[6,7,8],  #horizontal
  [0,3,6],[1,4,7],[2,5,8],  #vertical
  [0,4,8],[2,4,6]           #diagonal
]

def won?(board)
  if board.all? {|space| space == " "}
    return false
  end

  WIN_COMBINATIONS.each do |combination| #for each combination
    win_index_1 = combination[0]
    win_index_2 = combination[1] 
    win_index_3 = combination[2] 
    pos_1 = board[win_index_1]
    pos_2 = board[win_index_2]
    pos_3 = board[win_index_3]
    
    #if all of the "win" spaces of board are X or O
    if (pos_1 == "X" && pos_2 == "X" && pos_3 == "X") || (pos_1 == "O" && pos_2 == "O" && pos_3 == "O")
      return combination #return the entire array that won
    end #end if
  end #end iteration of WIN_COMBINATIONS
  
  if full?(board) #if no winner was found in the iteration, that means the combination wasn't returned.
    return false  #which means if the board is full, it's a draw.
  end #end if
end #end won?

def draw?(board)
  if !won?(board) && full?(board) #if full & no winner
    return true
  elsif (!won?(board) && !full?(board)) || won?(board) #else
    return false
  elsif full?(board)
  end
end

def full?(board) 
  board.any?{|space| space == " "} ? false : true 
end

def over?(board)
  if draw?(board) #if there is a draw
    print "Cat's Game!"
    return true
  elsif (won?(board) && !full?(board)) || (won?(board) && full?(board)) #if the game is won on a full or not full board
    return true
  else
    return false
  end
end

def winner(board)
  combination = won?(board) #if there is a winner it will return the combination
  if !over?(board) #if there is no draw or no winner the game is not over yet
    return nil 
  elsif board[combination[0]] == "X" #if the first winning index of board is "X" 
    return "X"
  else # otherwise, the game must be over, not a draw, & the winning player isn't "X" so it must be "O"
    return "O"
  end
end

