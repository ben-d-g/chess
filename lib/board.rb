class Board
  def initialize(empty = false)
    @grid = Array.new(8){Array.new(8){nil}}
    setup unless empty
  end

  def setup
    #add pieces individually
    @grid[0][0] = Rook.new("white")
    @grid[0][1] = Rook.new("white")
    @grid[0][2] = Bishop.new("white")
    @grid[0][3] = Queen.new("white")
    @grid[0][4] = King.new("white")
    @grid[0][5] = Bishop.new("white")
    @grid[0][6] = Rook.new("white")
    @grid[0][7] = Rook.new("white")

    @grid[7][0] = Rook.new("black")
    @grid[7][1] = Rook.new("black")
    @grid[7][2] = Bishop.new("black")
    @grid[7][3] = Queen.new("black")
    @grid[7][4] = King.new("black")
    @grid[7][5] = Bishop.new("black")
    @grid[7][6] = Rook.new("black")
    @grid[7][7] = Rook.new("black")

    #add pawns
    0.upto(7) do |col|
      @grid[1][col] = Pawn.new("white")
      @grid[6][col] = Pawn.new("black")
    end
  end

  def place_piece(piece, coord)
    @grid[coord[0]][coord[1]] = piece
  end

  attr_accessor :grid
end