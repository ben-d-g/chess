# frozen_string_literal: true

require_relative('piece')

class Knight < Piece
  def initialize(colour)
    @colour = colour
    @moves = { once: [[1, 2], [2, 1], [-1, 2], [2, -1], [1, -2], [-2, 1], [-1, -2], [-2, -1]], repeats: [] }
    @moved = false
  end

  attr_accessor :colour

  def get_piece
    return '♘' if @colour == 'white'

    '♞'
  end
end
