# Player class, describes player's attributes
class Player
  attr_accessor :name, :is_winner
  attr_reader :token
  def initialize(name, token)
    @name = name
    @token = token
    @is_winner = false
    puts "OK #{name} you will be playing with #{@token}"
  end
end

# Board class, describes and controls the board state
class Board
  attr_accessor :board_state
  def initialize()
    @board_state = [Array.new(3, " "), Array.new(3, " "), Array.new(3, " ")]
    self.show
  end

  # Shows the board state
  def show
    puts "#{board_state[0]}"
    puts "#{board_state[1]}"
    puts "#{board_state[2]}"
  end 

  # Controls the player's move
  def valid_move?(row, column)
    # Controls if the coordinates are valid
    if !row.between?(0,2) || !column.between?(0,2) 
      puts "Invalid move, please enter valid coordinates (row and column between 1 and 3)"
      return false 
    # Controls if the coordinates are available
    elsif board_state[row][column] != " " 
      print "Invalid move, the place #{move} is already marked with #{board_state[row][column]}"
      return false
    else
    # if everything is ok, returns true
      return true
    end  
  end

  # Updates the board after the player's move and shows the result
  def update(row, column, token)
    board_state[row][column] = token
    self.show
  end

  def check_win(player)
    for i in 0..2 do
      #check lines
       if board_state[i].all?{|cell| cell == player.token}
         player.is_winner = true
       end
      #check columns
       if board_state[0][i] == player.token && board_state[1][i] == player.token && board_state[2][i] == player.token
         player.is_winner = true
       end
    end
    #check both diagonals
    if (board_state[0][0] == player.token && board_state[1][1] == player.token && board_state[2][2] == player.token) || (board_state[0][2] == player.token && board_state[1][1] == player.token && board_state[2][0] == player.token)
      player.is_winner = true
     end
    if player.is_winner
      print "#{player.name} won the game !"
    end
  end
end

# Game engine
puts "Welcome to my awesome game of Tic Tac Toe!"
puts "Player 1, please enter your name"
player1 = Player.new(gets.chomp, "X")
puts "Player 2, please enter your name"
player2 = Player.new(gets.chomp, "O")
puts "Let's see the board :"
myBoard = Board.new

nb_turn = 1
draw = false

def get_player_move(board, player, nb_turn)
  validMove = false
  while validMove == false
    puts "Turn #{nb_turn} : #{player.name} please enter your move : row,column (for instance : 1,3)"
    move = gets.chomp.split(",").map{|c| c.to_i - 1}
    validMove = board.valid_move?(move[0], move[1])
  end
  if validMove
    board.update(move[0], move[1], player.token)
  end
  board.check_win(player)
end

while !player1.is_winner && !player2.is_winner && !draw
  get_player_move(myBoard, player1, nb_turn)
  nb_turn += 1
  if nb_turn >= 10 && !player1.is_winner
    puts "DRAW !"
    draw = true
  else
    get_player_move(myBoard, player2, nb_turn) if !player1.is_winner
    nb_turn += 1
  end  
end

