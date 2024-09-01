require_relative("piece")

class Knight < Piece
  def initialize(colour)
    @colour = colour
    @moves = {once: [[1,2], [2,1], [-1,2], [2,-1], [1,-2], [-2,1], [-1,-2],[-2,-1]], repeats: []}
    @moved = false
  end

  attr_accessor :colour

  def get_piece
    if @colour == "white"
      return "♘" 
    else
      return "♞"
    end
  end
end