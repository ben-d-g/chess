require_relative("piece")

class Queen < Piece
  def initialize(colour)
    @colour = colour
    @moves = {once: [], repeats: [[1,0], [1,1], [0,1], [-1,1], [-1,0], [-1,-1], [0,-1], [1,-1]]}
    @moved = false
  end

  attr_accessor :colour
end