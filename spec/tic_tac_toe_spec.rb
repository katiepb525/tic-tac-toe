# frozen_string_literal: true

require './lib/tic_tac_toe'

describe NewGame do
  # double for player class
  let(:current_player) { double('player', name: 'Jessie', symbol: 'X') }
  let(:second_player) { double('player', name: 'James', symbol: 'O') }

  # double for grid class
  let(:grid) { instance_double(Grid, place: [1, 2, 3, 4, 5, 6, 7, 8, 9]) }

  # initialize subject var
  subject(:game) { described_class.new(current_player, second_player, grid) }

  ######### tests for win conditions #########

  describe '#player_won?' do
    context 'the player wins a row' do
      before do
        allow(game).to receive(:won_row?).and_return(true)
      end

      it 'changes game_end to true' do
        expect { game.player_won?(current_player) }.to change { game.instance_variable_get(:@game_end) }.to be(true)
      end
    end

    context 'the player wins a column' do
      before do
        allow(game).to receive(:won_column?).and_return(true)
      end

      it 'changes game_end to true' do
        expect { game.player_won?(current_player) }.to change { game.instance_variable_get(:@game_end) }.to be(true)
      end
    end

    context 'the player wins a diagonal' do
      before do
        allow(game).to receive(:won_diag?).and_return(true)
      end

      it 'changes game_end to true' do
        expect { game.player_won?(current_player) }.to change { game.instance_variable_get(:@game_end) }.to be(true)
      end
    end

    context 'the player does not win' do
      it 'does not change game_end to true' do
        expect { game.player_won?(current_player) }.not_to change { game.instance_variable_get(:@game_end) }
      end
    end
  end

  describe '#won_row?' do
    context 'all of first row contains current players symbol' do
      let(:grid) { instance_double(Grid, place: ['X', 'X', 'X', 4, 5, 6, 7, 8, 9]) }

      it 'returns true' do
        expect(game.won_row?(current_player)).to be(true)
      end
    end

    context 'all of second row contains current players symbol' do
      let(:grid) { instance_double(Grid, place: [1, 2, 3, 'X', 'X', 'X', 7, 8, 9]) }

      it 'returns true' do
        expect(game.won_row?(current_player)).to be(true)
      end
    end

    context 'all of third row contains current players symbol' do
      let(:grid) { instance_double(Grid, place: [1, 2, 3, 4, 5, 6, 'X', 'X', 'X']) }

      it 'returns true' do
        expect(game.won_row?(current_player)).to be(true)
      end
    end

    context 'no winning rows on the grid' do
      let(:grid) { instance_double(Grid, place: [1, 2, 'O', 4, 5, 6, 'O', 'X', 'X']) }

      it 'returns false' do
        expect(game.won_row?(current_player)).to be(false)
      end
    end
  end

  describe '#won_column?' do
    context 'all of the first column contains current player symbol' do
      let(:grid) { instance_double(Grid, place: ['X', 2, 3, 'X', 5, 6, 'X', 8, 9]) }

      it 'returns true' do
        expect(game.won_column?(current_player)).to be(true)
      end
    end

    context 'all of the second column contains current player symbol' do
      let(:grid) { instance_double(Grid, place: [1, 'X', 3, 4, 'X', 6, 7, 'X', 9]) }

      it 'returns true' do
        expect(game.won_column?(current_player)).to be(true)
      end
    end

    context 'all of the third column contains current player symbol' do
      let(:grid) { instance_double(Grid, place: [1, 2, 'X', 4, 5, 'X', 7, 8, 'X']) }

      it 'returns true' do
        expect(game.won_column?(current_player)).to be(true)
      end
    end

    context 'none of the columns contain current player symbol consecutively' do
      let(:grid) { instance_double(Grid, place: ['O', 2, 'O', 4, 5, 'X', 7, 8, 'X']) }

      it 'returns nil' do
        expect(game.won_column?(current_player)).to be_nil
      end
    end
  end

  describe '#won_diag?' do
    context 'first diagonal wins' do
      let(:grid) { instance_double(Grid, place: ['X', 2, 3, 4, 'X', 6, 7, 8, 'X']) }

      it 'returns true' do
        expect(game.won_diag?(current_player)).to be(true)
      end
    end

    context 'second diagonal wins' do
      let(:grid) { instance_double(Grid, place: [1, 2, 'X', 4, 'X', 6, 'X', 8, 9]) }

      it 'returns true' do
        expect(game.won_diag?(current_player)).to be(true)
      end
    end

    context 'no diagonals win' do
      let(:grid) { instance_double(Grid, place: ['X', 2, 'O', 4, 'X', 6, 'X', 8, 9]) }

      it 'returns nil' do
        expect(game.won_diag?(current_player)).to be_nil
      end
    end
  end

  describe '#tie?' do
    context 'grid is fully marked' do
      let(:grid) { instance_double(Grid, place: %w[X X O O X O X O O]) }

      it 'puts receives message' do
        expect(game).to receive(:puts).with('it was a tie!')
        game.tie?
      end

      it 'changes game_end to true' do
        expect { game.tie? }.to change { game.instance_variable_get(:@game_end) }.to(true)
      end
    end

    context 'grid is NOT fully marked' do
      let(:grid) { instance_double(Grid, place: ['X', 'X', 2, 'O', 'X', 'O', 6, 'O', 'O']) }

      it 'returns nil' do
        expect(game.tie?).to be_nil
      end
    end
  end

  ####### tests for gameplay #######

  describe '#update_square' do
    it 'updates grid.place[index] with current players symbol' do
      index = 1
      expect { game.update_square(index, current_player) }.to change { grid.place[1] }.to eq('X')
    end
  end

  describe '#play_round' do
    it 'displays the board' do
      expect(grid).to receive(:display_board).twice
      game.play_round(current_player)
    end

    # context 'chosen spot by player is not taken' do
    #   it 'updates square with chosen spot' do

    #   end
    # end

    # context 'chosen spot by player IS taken' do
    #   it 'loops until player chooses open spot, then records choice' do
    #   end

    #   it 'updates square with chosen spot' do
    #   end
    # end
  end
end
