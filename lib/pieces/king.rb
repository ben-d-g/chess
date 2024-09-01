# frozen_string_literal: true

require_relative('piece')

class King < Piece
  def initialize(colour)
    @colour = colour
    @moves = { once: [[1, 0], [1, 1], [0, 1], [-1, 1], [-1, 0], [-1, -1], [0, -1], [1, -1]], repeats: [] }
    @moved = false
  end

  def get_piece
    return '♔' if @colour == 'white'

    '♚'
  end

  attr_accessor :colour
end
