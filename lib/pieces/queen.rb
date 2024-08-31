require_relative("piece")

class Queen < Piece
  def initialize(colour)
    @colour = colour
    @moves = {once: [], repeats: []}
  end
end