# frozen_string_literal: true

require_relative('piece')

class Pawn < Piece
  def initialize(colour)
    @colour = colour
    @moves = {}
    @moves = if @colour == 'white'
               { once: [[1, 0], [2, 0]], repeats: [] }
             else
               { once: [[-1, 0], [-2, 0]], repeats: [] }
             end
    @moved = false
  end

  def get_piece
    return '♙' if @colour == 'white'

    '♟︎'
  end

  attr_accessor :colour

  def update_moves
    @moves = if !moved
               if @colour == 'white'
                 { once: [[1, 0], [2, 0]], repeats: [] }
               else
                 { once: [[-1, 0], [-2, 0]], repeats: [] }
               end
             elsif @colour == 'white'
               { once: [[1, 0]], repeats: [] }
             else
               { once: [[-1, 0]], repeats: [] }
             end
  end

  def valid_moves(coords, board)
    move_list = super(coords, board)

    # Add diagonal captures
    diagonal_moves = [[1, -1], [1, 1]]
    diagonal_moves.each do |move|
      new_coords = [coords[0] + move[0], coords[1] + move[1]]
      next unless new_coords.all? { |c| c.between?(0, 7) }

      target_square = board.grid[new_coords[0]][new_coords[1]]
      move_list.push(new_coords) if target_square && target_square.colour != @colour
    end

    move_list
  end
end
