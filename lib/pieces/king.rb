require_relative("piece")

class King < Piece
  def initialize(colour)
    @colour = colour
    @moves = {once: [[1,0], [1,1], [0,1], [-1,1], [-1,0], [-1,-1], [0,-1], [1,-1]], repeats: []}
    @moved = false
  end

  def get_piece
    if @colour == "white"
      return "♔" 
    else
      return "♚"
    end
  end

  attr_accessor :colour
end