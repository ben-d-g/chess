class Piece
  def initialize(colour)
    @colour = colour
    @moves = {once: [], repeats: []}
  end

  attr_accessor :type, :colour
end