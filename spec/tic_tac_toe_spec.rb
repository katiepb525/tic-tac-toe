require './lib/tic_tac_toe'

describe NewGame do
  describe '#player_won?' do
    # double for player class
    let(:current_player){ double('player', name: 'Jessie')}
    let(:second_player){ double('player', name: 'James')}
    # double for grid class
    let(:grid){double('grid')}

    # initialize subject var
    subject(:won_game){described_class.new(current_player, second_player, grid)}

    context 'the player wins a row' do
      before do
        allow(won_game).to receive(:won_row?).and_return(true)
        allow(won_game).to receive(:won_column?).and_return(false)
        allow(won_game).to receive(:won_diag?).and_return(false)
      end

      it 'changes game_end to true' do
        expect{won_game.player_won?(current_player)}.to change{won_game.instance_variable_get(:@game_end)}.to be(true)
      end
    end

    context 'the player wins a column' do
      before do
        allow(won_game).to receive(:won_row?).and_return(false)
        allow(won_game).to receive(:won_column?).and_return(true)
        allow(won_game).to receive(:won_diag?).and_return(false)
      end

      it 'changes game_end to true' do
        expect{won_game.player_won?(current_player)}.to change{won_game.instance_variable_get(:@game_end)}.to be(true)
      end
    end

    context 'the player wins a diagonal' do
      before do
        allow(won_game).to receive(:won_row?).and_return(false)
        allow(won_game).to receive(:won_column?).and_return(false)
        allow(won_game).to receive(:won_diag?).and_return(true)
      end

      it 'changes game_end to true' do
        expect{won_game.player_won?(current_player)}.to change{won_game.instance_variable_get(:@game_end)}.to be(true)
      end
    end

    context 'the player does not win' do
      before do
        allow(won_game).to receive(:won_row?).and_return(false)
        allow(won_game).to receive(:won_column?).and_return(false)
        allow(won_game).to receive(:won_diag?).and_return(false)
      end

      it 'does not change game_end to true' do
        expect{won_game.player_won?(current_player)}.not_to change{won_game.instance_variable_get(:@game_end)}
      end
    end
  end

  describe '#won_row?' do
    # double for player class
    let(:current_player){ double('player', name: 'Jessie', symbol: 'X')}
    let(:second_player){ double('player', name: 'James', symbol: 'O')}

    context 'all of first row contains current players symbol' do
      # double for grid class with first row full of X's
      let(:grid){double('grid', place: ['X','X','X',4,5,6,7,8,9])}
      # initialize subject var
      subject(:won_row){described_class.new(current_player, second_player, grid)}

      it 'returns true' do
        expect(won_row.won_row?(current_player)).to be(true)
      end
    end

    context 'all of second row contains current players symbol' do
      # double for grid class with second row full of X's
      let(:grid){double('grid', place: [1,2,3,'X','X','X',7,8,9])}
      # initialize subject var
      subject(:won_row){described_class.new(current_player, second_player, grid)}

      it 'returns true' do
        expect(won_row.won_row?(current_player)).to be(true)
      end
    end

    context 'all of third row contains current players symbol' do
      # double for grid class with third row full of X's
      let(:grid){double('grid', place: [1,2,3,4,5,6,'X','X','X'])}
      
      # initialize subject var
      subject(:won_row){described_class.new(current_player, second_player, grid)}

      it 'returns true' do
        expect(won_row.won_row?(current_player)).to be(true)
      end
    end

    context 'no winning rows on the grid' do
      # double for grid class that has no winning rows
      let(:grid){double('grid', place: [1,2,'O',4,5,6,'O','X','X'])}
      
      # initialize subject var
      subject(:won_row){described_class.new(current_player, second_player, grid)}

      it 'returns false' do
        expect(won_row.won_row?(current_player)).to be(false)
      end
    end
  end
end