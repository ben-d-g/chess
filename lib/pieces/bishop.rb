require_relative("piece")

class Bishop < Piece
  def initialize(colour)
    @colour = colour
    @moves = {once: [], repeats: [[1,1], [-1,1], [1,-1], [-1,-1]]}
    @moved = false
  end

  attr_accessor :colour
end