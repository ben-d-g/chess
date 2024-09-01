# frozen_string_literal: true

require_relative('piece')

class Queen < Piece
  def initialize(colour)
    @colour = colour
    @moves = { once: [], repeats: [[1, 0], [1, 1], [0, 1], [-1, 1], [-1, 0], [-1, -1], [0, -1], [1, -1]] }
    @moved = false
  end

  def get_piece
    return '♕' if @colour == 'white'

    '♛'
  end

  attr_accessor :colour
end
