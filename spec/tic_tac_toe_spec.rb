require './lib/tic_tac_toe'

describe NewGame do
  describe '#player_won?' do
    # double for player class
    let(:current_player){ double('player', name: 'Jessie')}
    let(:second_player){ double('player', name: 'James')}
    # double for grid class
    let(:grid){double('grid')}

    # initalize subject var
    subject(:win_row){described_class.new(current_player, second_player, grid)}

    context 'the player wins a row' do
      before do
        allow(win_row).to receive(:won_row?).and_return(true)
        allow(win_row).to receive(:won_column?).and_return(false)
        allow(win_row).to receive(:won_diag?).and_return(false)
      end

      it 'changes game_end to true' do
        expect{win_row.player_won?(current_player)}.to change{win_row.instance_variable_get(:@game_end)}.to be(true)
      end
    end

    context 'the player wins a column' do
      before do
        allow(win_row).to receive(:won_row?).and_return(false)
        allow(win_row).to receive(:won_column?).and_return(true)
        allow(win_row).to receive(:won_diag?).and_return(false)
      end

      it 'changes game_end to true' do
        expect{win_row.player_won?(current_player)}.to change{win_row.instance_variable_get(:@game_end)}.to be(true)
      end
    end

    context 'the player wins a diagonal' do
      before do
        allow(win_row).to receive(:won_row?).and_return(false)
        allow(win_row).to receive(:won_column?).and_return(false)
        allow(win_row).to receive(:won_diag?).and_return(true)
      end

      it 'changes game_end to true' do
        expect{win_row.player_won?(current_player)}.to change{win_row.instance_variable_get(:@game_end)}.to be(true)
      end
    end

    context 'the player does not win' do
      before do
        allow(win_row).to receive(:won_row?).and_return(false)
        allow(win_row).to receive(:won_column?).and_return(false)
        allow(win_row).to receive(:won_diag?).and_return(false)
      end

      it 'does not change game_end to true' do
        expect{win_row.player_won?(current_player)}.not_to change{win_row.instance_variable_get(:@game_end)}
      end
    end
    
  end

end