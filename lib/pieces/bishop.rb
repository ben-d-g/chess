require_relative("piece")

class Bishop < Piece
  def initialize(colour)
    @colour = colour
    @moves = {once: [], repeats: []}
  end
end