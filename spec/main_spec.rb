require_relative '../main'

describe ConnectFour do
  
  describe '#player_input' do

    subject(:game_input) { described_class.new }
    
    context 'player makes valid input' do

      before do
        valid_input = '3\n'
        allow(game_input).to receive(:gets).and_return(valid_input)
      end

      it 'does not raise error message' do
        error_message = 'Input error! Enter a number between 1 and 7.'
        expect(game_input).not_to receive(:puts).with(error_message)
        game_input.player_input
      end
    end
    
    context 'player makes invalid input, then correct input' do

      before do
        letter = 'e\n'
        valid_input = '3\n'
        allow(game_input).to receive(:gets).and_return(letter, valid_input)
      end
    
      it 'completes loop and displays error message once' do
        error_message = 'Input error! Enter a number between 1 and 7.'
        expect(game_input).to receive(:puts).with(error_message).once
        game_input.player_input
      end
    end

    context 'player makes 2 invalid inputs, then correct input' do
        
        before do
            letter = 'e\n'
            bad_number = '100\n'
            valid_input = '3\n'
            allow(game_input).to receive(:gets).and_return(letter, bad_number, valid_input)
        end
        
        it 'completes loop and displays error message twice' do
            error_message = 'Input error! Enter a number between 1 and 7.'
            expect(game_input).to receive(:puts).with(error_message).twice
            game_input.player_input
        end
      end
  end
end