# frozen_string_literal: true

# spec/chess_spec.rb

require 'rspec'
require_relative '../lib/chess'
require_relative '../lib/board'
require_relative '../lib/pieces/piece'
require_relative '../lib/pieces/pawn'
require_relative '../lib/pieces/rook'
require_relative '../lib/pieces/knight'
require_relative '../lib/pieces/bishop'
require_relative '../lib/pieces/queen'
require_relative '../lib/pieces/king'

RSpec.describe Chess do
  describe 'Chess Game Initialization' do
    it 'initializes a new game' do
      game = Chess.new
      expect(game).to be_a(Chess)
    end

    it 'creates a board with pieces in the correct initial positions' do
      board = Board.new
      expect(board.setup).to be_truthy
      expect(board.grid[0][0]).to be_a(Piece)
      expect(board.grid[7][7]).to be_a(Piece)
    end

    it 'setup does not place pieces in wrong positions' do
      board = Board.new
      expect(board.grid[3][2]).to_not be_a(Piece)
      expect(board.grid[5][0]).to_not be_a(Piece)
    end

    it 'setup places correct pieces in correct places' do
      board = Board.new
      expect(board.grid[0][0]).to be_a(Rook)
      expect(board.grid[6][5]).to be_a(Pawn)
      expect(board.grid[7][3]).to be_a(Queen)
      expect(board.grid[0][3]).to be_a(Queen)
      expect(board.grid[7][4]).to be_a(King)
      expect(board.grid[0][4]).to be_a(King)
    end

    it 'setup places correct colours in correct places' do
      board = Board.new
      expect(board.grid[0][0].colour).to eq('white')
      expect(board.grid[6][5].colour).to eq('black')
      expect(board.grid[7][3].colour).to eq('black')
      expect(board.grid[0][3].colour).to eq('white')
      expect(board.grid[7][4].colour).to eq('black')
      expect(board.grid[0][4].colour).to eq('white')
    end
  end

  describe 'Chess Game Play' do
    let(:game) { Chess.new }
    let(:board) { game.board }

    it 'translates algebraic notation' do
      expect(board.at(game.algebraic_translator('a1'))).to be_a(Rook)
    end

    it 'allows players to make valid moves' do
      move = game.make_move('e2', 'e4')
      expect(move).to be_truthy
      expect(board.grid[3][4]).to be_a(Piece) # assuming 'e4' is translated to [4, 4]
      expect(board.grid[1][4]).to be_nil
    end

    it 'does not allow invalid moves' do
      move = game.make_move('e2', 'e5')
      expect(move).to be_falsey
    end

    it 'detects check conditions' do
      empty_game = Chess.new(true)
      empty_board = empty_game.board
      # Set up a board where one player is in check
      empty_board.place_piece(King.new('black'), [0, 4]) # Black king on e1
      empty_board.place_piece(Rook.new('white'), [0, 7]) # White rook on h1
      expect(empty_game.check?('black')).to be_truthy
    end

    it 'detects checkmate conditions' do
      empty_game = Chess.new(true)
      empty_board = empty_game.board
      # Set up a board where checkmate is unavoidable
      empty_board.place_piece(King.new('black'), [0, 4]) # Black king on e1
      empty_board.place_piece(Rook.new('white'), [0, 7]) # White rook on h1
      empty_board.place_piece(Queen.new('white'), [1, 7]) # White queen on e2
      expect(empty_game.checkmate?('black')).to be_truthy
    end

    it 'detects stalemate conditions' do
      empty_game = Chess.new(true)
      empty_board = empty_game.board
      # Set up a stalemate scenario
      empty_board.place_piece(King.new('black'), [7, 5]) # Black king on h8
      empty_board.place_piece(Bishop.new('white'), [6, 5]) # White king on g7
      empty_board.place_piece(King.new('white'), [5, 5]) # White queen on h7
      expect(empty_game.stalemate?(:black)).to be_truthy
    end
  end
end
