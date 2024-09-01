require_relative("piece")

class Queen < Piece
  def initialize(colour)
    @colour = colour
    @moves = {once: [], repeats: [[1,0], [1,1], [0,1], [-1,1], [-1,0], [-1,-1], [0,-1], [1,-1]]}
    @moved = false
  end

  def get_piece
    if @colour == "white"
      return "♕"
    else
      return "♛"
    end
  end

  attr_accessor :colour
end