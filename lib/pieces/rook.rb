require_relative("piece")

class Rook < Piece
  def initialize(colour)
    @colour = colour
    @moves = {once: [], repeats: []}
  end
end