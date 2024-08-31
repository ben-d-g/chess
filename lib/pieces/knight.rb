require_relative("piece")

class Knight < Piece
  def initialize(colour)
    @colour = colour
    @moves = {once: [], repeats: []}
  end
end