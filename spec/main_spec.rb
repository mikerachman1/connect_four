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

  describe '#update_board' do

    subject(:game_board) { described_class.new }

    context 'First player move in empty slot' do

      before do
        game_board.instance_variable_set(:@turn, 1)
      end
    
      it 'Updates game board array accordingly' do
        column = 1
        board = game_board.board
        expect { game_board.update_board(column) }.to change { board[0].length }.by(1) 
      end
    end

    context 'Move into slot with other pieces' do

      before do
        game_board.instance_variable_set(:@turn, 2)
        game_board.instance_variable_set(:@board, [[], ['X', 'X'], [], [], [], [], []])
      end
      
      it 'Updates game board array accordingly' do
        column = 2
        board = game_board.board
        game_board.update_board(column)
        expect(board[1][2]).to eq('O') 
      end 
    end
  end

  describe '#verify_input' do

    subject(:game_verify) { described_class.new }

    context 'valid move, empty spaces in column' do
      it 'returns input' do
        column = 1
        expect(game_verify.verify_input(column)).to eq(column)
      end
    end

    context 'invalid move, spaces full in column' do

      before do
        game_verify.instance_variable_set(:@board, [['X', 'O', 'X', 'O', 'X', 'O'], [], [], [], [], [], []])
      end

      it 'returns nil' do
        column = 1
        expect(game_verify.verify_input(column)).to be_nil
      end
    end
  end

  describe '#change_turn' do

    subject(:game_change) { described_class.new }

    context 'Was P1 turn last' do

      before do
        game_change.instance_variable_set(:@turn, 1)
      end

      it 'changes to P2 turn' do
        game_change.change_turn
        expect(game_change.turn).to eq(2)
      end
    end

    context 'Was P2 turn last' do

      before do
        game_change.instance_variable_set(:@turn, 2)
      end

      it 'changes to P1 turn' do
        game_change.change_turn
        expect(game_change.turn).to eq(1)
      end
    end
  end

  describe '#game_over?' do

    subject(:game_end) { described_class.new }

    context 'horizontal connect 4' do
      
      before do
        game_end.instance_variable_set(:@board, [['X'], ['X'], ['X'], ['X'], [], [], []])
      end
      
      it 'returns true' do
        expect(game_end.game_over?).to be true
      end
    end

    context 'vertical connect 4' do

      before do
        game_end.instance_variable_set(:@board, [['X', 'X', 'X', 'X'], [], [], [], [], [], []])
      end

      it 'returns true' do
        expect(game_end.game_over?).to be true
      end
    end

    context 'diagonal connect 4' do

      before do
        game_end.instance_variable_set(:@board, [['X'], ['O', 'X'], ['O', 'O', 'X'], ['O', 'O', 'O', 'X'], [], [], []])
      end

      it 'returns true' do
        expect(game_end.game_over?).to be true
      end
    end

    context 'game isnt over' do
        
      it 'returns false' do
        expect(game_end.game_over?).to be false
      end
    end
  end
end