require_relative("piece")

class Queen < Piece
  def initialize(colour)
    @colour = colour
    @moves = {once: [], repeats: [[1,0], [1,1], [0,1], [-1,1], [-1,0], [-1,-1], [0,-1], [1,-1]]}
  end

  attr_accessor :colour
end