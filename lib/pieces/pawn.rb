require_relative("piece")

class Pawn < Piece
  def initialize(colour)
    @colour = colour
    @moves = {once: [[1, 0], [2, 0]], repeats: []}
    @moved = false
  end

  def get_piece
    if @colour == "white"
      return "♙"
    else
      return "♟︎"
    end
  end

  attr_accessor :colour

  def update_moves
    if !moved
      @moves[:once] = [[1, 0], [2, 0]]
    else
      @moves[:once] = [[1, 0]]
    end
  end

  def valid_moves(coords, board)
    move_list = super(coords, board)
    
    # Add diagonal captures
    diagonal_moves = [[1, -1], [1, 1]]
    diagonal_moves.each do |move|
      new_coords = [coords[0] + move[0], coords[1] + move[1]]
      if new_coords.all? { |c| c.between?(0, 7) }
        target_square = board.grid[new_coords[0]][new_coords[1]]
        if target_square && target_square.colour != @colour
          move_list.push(new_coords)
        end
      end
    end
    
    move_list
  end
end
