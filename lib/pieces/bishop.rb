require_relative("piece")

class Bishop < Piece
  def initialize(colour)
    @colour = colour
    @moves = {once: [], repeats: [[1,1], [-1,1], [1,-1], [-1,-1]]}
  end

  attr_accessor :colour
end