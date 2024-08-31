class Board
  def initialize
    @grid = Array.new(8){Array.new(8){nil}}
  end

  def setup
    #add pieces individually
    @grid[0][0] = Piece.new
    @grid[0][1] = Piece.new
    @grid[0][2] = Piece.new
    @grid[0][3] = Piece.new
    @grid[0][4] = Piece.new
    @grid[0][5] = Piece.new
    @grid[0][6] = Piece.new
    @grid[0][7] = Piece.new

    @grid[7][0] = Piece.new
    @grid[7][1] = Piece.new
    @grid[7][2] = Piece.new
    @grid[7][3] = Piece.new
    @grid[7][4] = Piece.new
    @grid[7][5] = Piece.new
    @grid[7][6] = Piece.new
    @grid[7][7] = Piece.new

    #add pawns
    0.upto(7) do |col|
      @grid[1][col] = Piece.new
      @grid[6][col] = Piece.new
    end
  end

  attr_accessor :grid
end