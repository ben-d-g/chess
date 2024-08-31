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

RSpec.describe 'Piece Movement' do
  let(:board) { Board.new }

  describe 'Pawn movement' do
    xit 'allows pawns to move forward by one square' do
      pawn = Pawn.new("white")
      board.place_piece(pawn, [1, 0]) # Place white pawn on a2 (index [1, 0])
      expect(pawn.valid_move?([1, 0], [2, 0], board)).to be_truthy # a2 to a3
    end

    xit 'allows pawns to move forward by two squares on their first move' do
      pawn = Pawn.new("white")
      board.place_piece(pawn, [1, 0]) # Place white pawn on a2
      expect(pawn.valid_move?([1, 0], [3, 0], board)).to be_truthy # a2 to a4
    end

    xit 'does not allow pawns to move backward' do
      pawn = Pawn.new("white")
      board.place_piece(pawn, [2, 0]) # Place white pawn on a3
      expect(pawn.valid_move?([2, 0], [1, 0], board)).to be_falsey # a3 to a2 (invalid)
    end

    xit 'allows pawns to capture diagonally' do
      pawn = Pawn.new("white")
      enemy_pawn = Pawn.new("black")
      board.place_piece(pawn, [2, 0]) # Place white pawn on a3
      board.place_piece(enemy_pawn, [3, 1]) # Place black pawn on b4
      expect(pawn.valid_move?([2, 0], [3, 1], board)).to be_truthy # a3 to b4
    end
  end

  describe 'Rook movement' do
    xit 'allows rooks to move vertically' do
      rook = Rook.new("white")
      board.place_piece(rook, [0, 0]) # Place white rook on a1
      expect(rook.valid_move?([0, 0], [3, 0], board)).to be_truthy # a1 to a4
    end

    xit 'allows rooks to move horizontally' do
      rook = Rook.new("white")
      board.place_piece(rook, [0, 0]) # Place white rook on a1
      expect(rook.valid_move?([0, 0], [0, 4], board)).to be_truthy # a1 to e1
    end

    xit 'does not allow rooks to move diagonally' do
      rook = Rook.new("white")
      board.place_piece(rook, [0, 0]) # Place white rook on a1
      expect(rook.valid_move?([0, 0], [2, 2], board)).to be_falsey # a1 to c3 (invalid)
    end
  end

  describe 'Knight movement' do
    xit 'allows knights to move in an L shape' do
      knight = Knight.new("white")
      board.place_piece(knight, [0, 1]) # Place white knight on b1
      expect(knight.valid_move?([0, 1], [2, 2], board)).to be_truthy # b1 to c3
      expect(knight.valid_move?([0, 1], [1, 3], board)).to be_truthy # b1 to d2
    end

    xit 'does not allow knights to move like a bishop' do
      knight = Knight.new("white")
      board.place_piece(knight, [0, 1]) # Place white knight on b1
      expect(knight.valid_move?([0, 1], [2, 3], board)).to be_falsey # b1 to d3 (invalid)
    end
  end

  describe 'Bishop movement' do
    xit 'allows bishops to move diagonally' do
      bishop = Bishop.new("white")
      board.place_piece(bishop, [0, 2]) # Place white bishop on c1
      expect(bishop.valid_move?([0, 2], [2, 4], board)).to be_truthy # c1 to e3
    end

    xit 'does not allow bishops to move horizontally or vertically' do
      bishop = Bishop.new("white")
      board.place_piece(bishop, [0, 2]) # Place white bishop on c1
      expect(bishop.valid_move?([0, 2], [0, 3], board)).to be_falsey # c1 to d1 (invalid)
      expect(bishop.valid_move?([0, 2], [1, 2], board)).to be_falsey # c1 to c2 (invalid)
    end
  end

  describe 'Queen movement' do
    xit 'allows queens to move vertically, horizontally, or diagonally' do
      queen = Queen.new("white")
      board.place_piece(queen, [0, 3]) # Place white queen on d1
      expect(queen.valid_move?([0, 3], [3, 3], board)).to be_truthy # d1 to d4 (vertical)
      expect(queen.valid_move?([0, 3], [0, 0], board)).to be_truthy # d1 to a1 (horizontal)
      expect(queen.valid_move?([0, 3], [2, 5], board)).to be_truthy # d1 to f3 (diagonal)
    end

    xit 'does not allow queens to move in an invalid pattern' do
      queen = Queen.new("white")
      board.place_piece(queen, [0, 3]) # Place white queen on d1
      expect(queen.valid_move?([0, 3], [1, 5], board)).to be_falsey # d1 to f2 (invalid)
    end
  end

  describe 'King movement' do
    xit 'allows kings to move one square in any direction' do
      king = King.new("white")
      board.place_piece(king, [0, 4]) # Place white king on e1
      expect(king.valid_move?([0, 4], [1, 4], board)).to be_truthy # e1 to e2
      expect(king.valid_move?([0, 4], [0, 3], board)).to be_truthy # e1 to d1
      expect(king.valid_move?([0, 4], [1, 5], board)).to be_truthy # e1 to f2
    end

    xit 'does not allow kings to move more than one square' do
      king = King.new("white")
      board.place_piece(king, [0, 4]) # Place white king on e1
      expect(king.valid_move?([0, 4], [2, 4], board)).to be_falsey # e1 to e3 (invalid)
    end

    xit 'allows castling under correct conditions' do
      king = King.new("white")
      rook = Rook.new("white")
      board.place_piece(king, [0, 4]) # Place white king on e1
      board.place_piece(rook, [0, 7]) # Place white rook on h1
      board.clear_path([0, 4], [0, 7]) # Simulate the path is clear for castling
      expect(king.valid_move?([0, 4], [0, 6], board)).to be_truthy # e1 to g1 (castling)
    end
  end
end
