class ConnectFour
  attr_accessor :board, :turn

  def initialize
    @board = Array.new(7) { Array.new }
    @turn = rand(1..2)
  end

  def player_input
    loop do
      input = gets.chomp.to_i
      return input if input.between?(1, 7)

      puts 'Input error! Enter a number between 1 and 7.'
    end
  end

  def verify_input(row)
    board[(row - 1)].length == 6 ? nil : row
  end

  def update_board(row)
    turn == 1 ? piece = 'X' : piece = 'O'
    board[(row - 1)] << piece
    board
  end

  def change_turn
    @turn == 1 ? @turn = 2 : @turn = 1
  end
end

#  game = ConnectFour.new
# game.update_board(1)