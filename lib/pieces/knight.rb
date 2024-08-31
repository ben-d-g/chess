require_relative("piece")

class Knight < Piece
  def initialize(colour)
    @colour = colour
    @moves = {once: [[1,2], [2,1], [-1,2], [2,-1], [1,-2], [-2,1], [-1,-2],[-2,-1]], repeats: []}
  end
end