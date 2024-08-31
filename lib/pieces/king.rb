require_relative("piece")

class King < Piece
  def initialize(colour)
    @colour = colour
    @moves = {once: [], repeats: []}
  end
end