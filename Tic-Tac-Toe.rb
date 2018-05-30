#winning games
WIN_COMBINATIONS = [
  [0, 1, 2], #top row
  [3, 4, 5], #horizontal middle row
  [6, 7, 8], #bottom row
  [0, 3, 6], #left column
  [1, 4, 7], #middle column
  [2, 5, 8], #right column
  [0, 4, 8], #left diagonal
  [2, 4, 6]  #right diagonal
  ]

#prints current board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#translates 1-9 to board index
def input_to_index(input)
  input.to_i - 1
end

#checks if a space is taken
def position_taken?(board, i)
  board[i] == "X" || board[i] == "O"
end

#checks if index is valid and space is free
def valid_move?(board, i)
  i.integer? &&
  i <= 8 && i >= 0 &&
  !position_taken?(board, i)
end

#inserts X or O into desired space
def move(board, i, character)
  board[i] = character
  puts display_board(board)
end

#asks for input, makes move or repeats for invalid input
def turn(board)
  player = current_player(board)
  puts "It's #{player}'s turn!"
  puts "Please enter 1-9:"
  input = gets.strip
  i = input_to_index(input)
  if valid_move?(board, i)
    move(board, i, current_player(board))
  elsif valid_move?(board, i) == false
    puts "Sorry, that move isn't valid. Try again."
    puts "\n"
    puts turn(board)
  end
end

#counts the number of turns
def turn_count(board)
  counter = 0
  board.each do |i|
    if i != "" && i != " "
      counter += 1
    end
  end
  counter
end

#identifies who goes next
def current_player(board)
  if turn_count(board).even?
    "X"
  elsif turn_count(board).odd?
    "O"
  end
end

#checks whether someone has won, returns winning array
def won?(board)
  board.all? {|i| i != " " || i != ""}
  winning_array = WIN_COMBINATIONS.detect do |win_array|
    if win_array.all? {|position| board[position] == "X" } == true
      winning_array.inspect
    elsif win_array.all? {|position| board[position] == "O" } == true
      winning_array.inspect
    end
  end
end

#checks if board is full
def full?(board)
  board.none? {|i| i == "" || i == " "}
end

#checks if there is a draw
def draw?(board)
   won?(board) == nil && full?(board) == true
end

#checks if the game is over
def over?(board)
  if (draw?(board) == true) || (won?(board) != nil)
    over = true
  else
    over = false
  end
end

#identifies winner
def winner(board)
  if won?(board) != nil
    winner = board[won?(board)[0]]
  end
end

#creates loops to continue play until game is over
def play(board)
  until over?(board) == true
    turn(board)
  end
  if draw?(board) == true
      puts "Cats Game!"
  else puts "Congratulations #{winner(board)}!"
  end
end

#begins game and calls #play
def helper
  puts "Welcome to Tic Tac Toe!"
  puts display_board([1, 2, 3, 4, 5, 6, 7, 8, 9])
  play([" ", " ", " ", " ", " ", " ", " ", " ", " "])
end

helper

# ["X", " ", " ", " ", " ", " ", " ", " ", " "]