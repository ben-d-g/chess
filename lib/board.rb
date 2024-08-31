class Board
  def initialize
    @grid = Array.new(8){Array.new(8){nil}}
    setup
  end

  def setup
    #add pieces individually
    @grid[0][0] = Piece.new("rook", "white")
    @grid[0][1] = Piece.new("knight", "white")
    @grid[0][2] = Piece.new("bishop", "white")
    @grid[0][3] = Piece.new("queen", "white")
    @grid[0][4] = Piece.new("king", "white")
    @grid[0][5] = Piece.new("bishop", "white")
    @grid[0][6] = Piece.new("knight", "white")
    @grid[0][7] = Piece.new("rook", "white")

    @grid[7][0] = Piece.new("rook", "black")
    @grid[7][1] = Piece.new("knight", "black")
    @grid[7][2] = Piece.new("bishop", "black")
    @grid[7][3] = Piece.new("queen", "black")
    @grid[7][4] = Piece.new("king", "black")
    @grid[7][5] = Piece.new("bishop", "black")
    @grid[7][6] = Piece.new("knight", "black")
    @grid[7][7] = Piece.new("rook", "black")

    #add pawns
    0.upto(7) do |col|
      @grid[1][col] = Piece.new("pawn", "white")
      @grid[6][col] = Piece.new("pawn", "black")
    end
  end

  attr_accessor :grid
end