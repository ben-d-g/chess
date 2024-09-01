# frozen_string_literal: true

require_relative('piece')

class Bishop < Piece
  def initialize(colour)
    @colour = colour
    @moves = { once: [], repeats: [[1, 1], [-1, 1], [1, -1], [-1, -1]] }
    @moved = false
  end

  def get_piece
    return '♗' if @colour == 'white'

    '♝'
  end

  attr_accessor :colour
end
