class ConnectFour

  def player_input
    loop do
      input = gets.chomp.to_i
      return input if input.between?(1, 7)

      puts 'Input error! Enter a number between 1 and 7.'
    end
  end
  
end