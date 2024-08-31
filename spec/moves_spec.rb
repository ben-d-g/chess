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
  let(:board) { Board.new(true) }

  describe 'Pawn movement' do
    it 'allows pawns to move forward by one square' do
      pawn = Pawn.new("white")
      board.place_piece(pawn, [1, 0]) # Place white pawn on a2 (index [1, 0])
      expect(pawn.valid_move?([1, 0], [2, 0], board)).to be_truthy # a2 to a3
    end

    it 'allows pawns to move forward by two squares on their first move' do
      pawn = Pawn.new("white")
      board.place_piece(pawn, [1, 0]) # Place white pawn on a2
      expect(pawn.valid_move?([1, 0], [3, 0], board)).to be_truthy # a2 to a4
    end

    it 'does not allow pawns to move backward' do
      pawn = Pawn.new("white")
      board.place_piece(pawn, [2, 0]) # Place white pawn on a3
      expect(pawn.valid_move?([2, 0], [1, 0], board)).to be_falsey # a3 to a2 (invalid)
    end

    it 'allows pawns to capture diagonally' do
      pawn = Pawn.new("white")
      enemy_pawn = Pawn.new("black")
      board.place_piece(pawn, [2, 0]) # Place white pawn on a3
      board.place_piece(enemy_pawn, [3, 1]) # Place black pawn on b4
      expect(pawn.valid_move?([2, 0], [3, 1], board)).to be_truthy # a3 to b4
    end

    it 'does not allow pawns to capture their own color pieces' do
      pawn = Pawn.new("white")
      ally_pawn = Pawn.new("white")
      board.place_piece(pawn, [2, 0]) # Place white pawn on a3
      board.place_piece(ally_pawn, [3, 1]) # Place white pawn on b4
      expect(pawn.valid_move?([2, 0], [3, 1], board)).to be_falsey # a3 to b4 (should not capture own color)
    end
  end

  describe 'Rook movement' do
    it 'allows rooks to move vertically' do
      rook = Rook.new("white")
      board.place_piece(rook, [0, 0]) # Place white rook on a1
      expect(rook.valid_move?([0, 0], [3, 0], board)).to be_truthy # a1 to a4
    end

    it 'allows rooks to move horizontally' do
      rook = Rook.new("white")
      board.place_piece(rook, [0, 0]) # Place white rook on a1
      expect(rook.valid_move?([0, 0], [0, 4], board)).to be_truthy # a1 to e1
    end

    it 'does not allow rooks to move diagonally' do
      rook = Rook.new("white")
      board.place_piece(rook, [0, 0]) # Place white rook on a1
      expect(rook.valid_move?([0, 0], [2, 2], board)).to be_falsey # a1 to c3 (invalid)
    end

    it 'does not allow rooks to jump over pieces' do
      rook = Rook.new("white")
      blocking_piece = Pawn.new("black")
      board.place_piece(rook, [0, 0]) # Place white rook on a1
      board.place_piece(blocking_piece, [1, 0]) # Place black pawn on a2
      expect(rook.valid_move?([0, 0], [2, 0], board)).to be_falsey # a1 to a3 (blocked by pawn)
    end

    it 'allows rooks to capture opponent pieces' do
      rook = Rook.new("white")
      opponent_piece = Pawn.new("black")
      board.place_piece(rook, [0, 0]) # Place white rook on a1
      board.place_piece(opponent_piece, [0, 3]) # Place black pawn on d1
      expect(rook.valid_move?([0, 0], [0, 3], board)).to be_truthy # a1 to d1 (captures black pawn)
    end

    it 'does not allow rooks to capture their own color pieces' do
      rook = Rook.new("white")
      ally_piece = Pawn.new("white")
      board.place_piece(rook, [0, 0]) # Place white rook on a1
      board.place_piece(ally_piece, [0, 3]) # Place white pawn on d1
      expect(rook.valid_move?([0, 0], [0, 3], board)).to be_falsey # a1 to d1 (should not capture own color)
    end
  end

  describe 'Knight movement' do
    it 'allows knights to move in an L shape' do
      knight = Knight.new("white")
      board.place_piece(knight, [0, 1]) # Place white knight on b1
      expect(knight.valid_move?([0, 1], [2, 2], board)).to be_truthy # b1 to c3
      expect(knight.valid_move?([0, 1], [1, 3], board)).to be_truthy # b1 to d2
    end

    it 'allows knights to capture opponent pieces' do
      knight = Knight.new("white")
      opponent_piece = Pawn.new("black")
      board.place_piece(knight, [0, 1]) # Place white knight on b1
      board.place_piece(opponent_piece, [2, 2]) # Place black pawn on c3
      expect(knight.valid_move?([0, 1], [2, 2], board)).to be_truthy # b1 to c3 (captures black pawn)
    end

    it 'does not allow knights to capture their own color pieces' do
      knight = Knight.new("white")
      ally_piece = Pawn.new("white")
      board.place_piece(knight, [0, 1]) # Place white knight on b1
      board.place_piece(ally_piece, [2, 2]) # Place white pawn on c3
      expect(knight.valid_move?([0, 1], [2, 2], board)).to be_falsey # b1 to c3 (should not capture own color)
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

    xit 'does not allow bishops to jump over pieces' do
      bishop = Bishop.new("white")
      blocking_piece = Pawn.new("black")
      board.place_piece(bishop, [0, 2]) # Place white bishop on c1
      board.place_piece(blocking_piece, [1, 3]) # Place black pawn on d2
      expect(bishop.valid_move?([0, 2], [2, 4], board)).to be_falsey # c1 to e3 (blocked by pawn)
    end

    xit 'allows bishops to capture opponent pieces' do
      bishop = Bishop.new("white")
      opponent_piece = Pawn.new("black")
      board.place_piece(bishop, [0, 2]) # Place white bishop on c1
      board.place_piece(opponent_piece, [2, 4]) # Place black pawn on e3
      expect(bishop.valid_move?([0, 2], [2, 4], board)).to be_truthy # c1 to e3 (captures black pawn)
    end

    xit 'does not allow bishops to capture their own color pieces' do
      bishop = Bishop.new("white")
      ally_piece = Pawn.new("white")
      board.place_piece(bishop, [0, 2]) # Place white bishop on c1
      board.place_piece(ally_piece, [2, 4]) # Place white pawn on e3
      expect(bishop.valid_move?([0, 2], [2, 4], board)).to be_falsey # c1 to e3 (should not capture own color)
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

    xit 'does not allow queens to jump over pieces' do
      queen = Queen.new("white")
      blocking_piece = Pawn.new("black")
      board.place_piece(queen, [0, 3]) # Place white queen on d1
      board.place_piece(blocking_piece, [1, 3]) # Place black pawn on d2
      expect(queen.valid_move?([0, 3], [2, 3], board)).to be_falsey # d1 to d3 (blocked by pawn)
    end

    xit 'allows queens to capture opponent pieces' do
      queen = Queen.new("white")
      opponent_piece = Pawn.new("black")
      board.place_piece(queen, [0, 3]) # Place white queen on d1
      board.place_piece(opponent_piece, [2, 5]) # Place black pawn on f3
      expect(queen.valid_move?([0, 3], [2, 5], board)).to be_truthy # d1 to f3 (captures black pawn)
    end

    xit 'does not allow queens to capture their own color pieces' do
      queen = Queen.new("white")
      ally_piece = Pawn.new("white")
      board.place_piece(queen, [0, 3]) # Place white queen on d1
      board.place_piece(ally_piece, [2, 5]) # Place white pawn on f3
      expect(queen.valid_move?([0, 3], [2, 5], board)).to be_falsey # d1 to f3 (should not capture own color)
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

    xit 'does not allow kings to jump over pieces' do
      king = King.new("white")
      blocking_piece = Pawn.new("black")
      board.place_piece(king, [0, 4]) # Place white king on e1
      board.place_piece(blocking_piece, [1, 4]) # Place black pawn on e2
      expect(king.valid_move?([0, 4], [1, 4], board)).to be_falsey # e1 to e2 (blocked by pawn)
    end

    xit 'allows kings to capture opponent pieces' do
      king = King.new("white")
      opponent_piece = Pawn.new("black")
      board.place_piece(king, [0, 4]) # Place white king on e1
      board.place_piece(opponent_piece, [1, 4]) # Place black pawn on e2
      expect(king.valid_move?([0, 4], [1, 4], board)).to be_truthy # e1 to e2 (captures black pawn)
    end

    xit 'does not allow kings to capture their own color pieces' do
      king = King.new("white")
      ally_piece = Pawn.new("white")
      board.place_piece(king, [0, 4]) # Place white king on e1
      board.place_piece(ally_piece, [1, 4]) # Place white pawn on e2
      expect(king.valid_move?([0, 4], [1, 4], board)).to be_falsey # e1 to e2 (should not capture own color)
    end
  end
end
