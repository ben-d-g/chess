require_relative("piece")

class King < Piece
  def initialize(colour)
    @colour = colour
    @moves = {once: [[1,0], [1,1], [0,1], [-1,1], [-1,0], [-1,-1], [0,-1], [1,-1]], repeats: []}
  end
end