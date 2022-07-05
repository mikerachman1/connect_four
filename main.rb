class ConnectFour
  attr_accessor :board, :turn

  def initialize
    @board = Array.new(7) { Array.new }
    @turn = rand(1..2)
  end

  def play_game
    introduction
    until game_over? == true
      puts 'Enter a number between 1 and 7'
      input = player_input
      move = verify_input(input)
      update_board(move)
      display_board
      change_turn
    end
    puts 'GAME OVER'
  end

  def player_input
    loop do
      input = gets.chomp.to_i
      return input if input.between?(1, 7)

      puts 'Input error! Enter a number between 1 and 7.'
    end
  end

  def verify_input(column)
    board[(column - 1)].length == 6 ? nil : column
  end

  def update_board(column)
    turn == 1 ? piece = 'X' : piece = 'O'
    board[(column - 1)] << piece
    board
  end

  def change_turn
    @turn == 1 ? @turn = 2 : @turn = 1
  end

  def game_over?
    rows = [[], [], [], [], [], []]
    board.each do |column|
      #checks for vertical win
      return true if column.values_at(0..3).all?('X') || column.values_at(0..3).all?('O')
      return true if column.values_at(1..4).all?('X') || column.values_at(1..4).all?('O')
      return true if column.values_at(2..5).all?('X') || column.values_at(2..5).all?('O')
      #populates rows arrays
      rows[0] << column[0]
      rows[1] << column[1]
      rows[2] << column[2]
      rows[3] << column[3]
      rows[4] << column[4]
      rows[5] << column[5]
    end
    rows.each do |row|
      #checks for horizontal wins
      return true if row.values_at(0..3).all?('X') || row.values_at(0..3).all?('O')
      return true if row.values_at(1..4).all?('X') || row.values_at(1..4).all?('O')
      return true if row.values_at(2..5).all?('X') || row.values_at(2..5).all?('O')
      return true if row.values_at(3..6).all?('X') || row.values_at(3..6).all?('O')
    end
    four_value_diagonals = [ 
        [rows[2][0], rows[3][1], rows[4][2], rows[5][3]], 
        [rows[0][3], rows[1][4], rows[2][5], rows[3][6]], 
        [rows[0][3], rows[1][2], rows[2][1], rows[3][0]], 
        [rows[2][6], rows[3][5], rows[4][4], rows[5][3]]
      ]
    five_value_diagonals = [
        [rows[1][0], rows[2][1], rows[3][2], rows[4][3], rows[5][4]],
        [rows[0][2], rows[1][3], rows[2][4], rows[3][5], rows[4][6]],
        [rows[0][4], rows[1][3], rows[2][2], rows[3][1], rows[4][0]],
        [rows[1][6], rows[2][5], rows[3][4], rows[4][3], rows[5][2]]
      ]
    six_value_diagonals = [
        [rows[0][0], rows[1][1], rows[2][2], rows[3][3], rows[4][4], rows[5][5]],
        [rows[0][1], rows[1][2], rows[2][3], rows[3][4], rows[4][5], rows[5][6]],
        [rows[0][5], rows[1][4], rows[2][3], rows[3][2], rows[4][1], rows[5][0]],
        [rows[0][6], rows[1][5], rows[2][4], rows[3][3], rows[4][2], rows[5][1]]
      ]
    four_value_diagonals.each do |diagonal|
      return true if diagonal.values_at(0..3).all?('X') || diagonal.values_at(0..3).all?('O')
    end
    five_value_diagonals.each do |diagonal|
      return true if diagonal.values_at(0..3).all?('X') || diagonal.values_at(0..3).all?('O')
      return true if diagonal.values_at(1..4).all?('X') || diagonal.values_at(1..4).all?('O')
    end
    six_value_diagonals.each do |diagonal|
      return true if diagonal.values_at(0..3).all?('X') || diagonal.values_at(0..3).all?('O')
      return true if diagonal.values_at(1..4).all?('X') || diagonal.values_at(1..4).all?('O')
      return true if diagonal.values_at(2..5).all?('X') || diagonal.values_at(2..5).all?('O')
    end
    false
  end
  
  def introduction
    puts "Lets play Connect 4!\nPlayer one will be (X)\nPlayer 2 will be (O)"
    if turn == 1
      puts 'Player 1 goes first'
    else
      puts 'Player 2 goes first'
    end
  end

  def display_board
    rows = [[], [], [], [], [], []]
    board.each do |column|
      rows[0] << column[0]
      rows[1] << column[1]
      rows[2] << column[2]
      rows[3] << column[3]
      rows[4] << column[4]
      rows[5] << column[5]
    end
    p rows[5]
    p rows[4]
    p rows[3]
    p rows[2]
    p rows[1]
    p rows[0]
  end

end

# game = ConnectFour.new
# game.play_game