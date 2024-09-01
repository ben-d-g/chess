# frozen_string_literal: true

class Piece
  def valid_moves(coords, board)
    move_list = []

    # Single-step moves
    @moves[:once].each do |move|
      new_coords = [coords[0] + move[0], coords[1] + move[1]]
      next unless new_coords.all? { |coord| coord.between?(0, 7) }

      if board.grid[new_coords[0]][new_coords[1]].nil? || (board.grid[new_coords[0]][new_coords[1]].colour != @colour)
        move_list.push(new_coords)
      end
      # dealing with pawn capturing in most sloppy way possible:
      if board.grid[coords[0]][coords[1]].is_a?(Pawn) && (new_coords[1] == coords[1]) && !board.grid[new_coords[0]][new_coords[1]].nil?
        move_list.pop
      end
    end

    # Repeating moves
    @moves[:repeats].each do |move|
      counter = 1
      while (coords[0] + counter * move[0]).between?(0, 7) && (coords[1] + counter * move[1]).between?(0, 7)
        new_coords = [coords[0] + counter * move[0], coords[1] + counter * move[1]]
        if board.grid[new_coords[0]][new_coords[1]].nil?
          move_list.push(new_coords)
        else
          move_list.push(new_coords) if board.grid[new_coords[0]][new_coords[1]].colour != @colour
          break
        end
        counter += 1
      end
    end

    move_list
  end

  def valid_move?(start_coords, end_coords, board)
    valid_moves(start_coords, board).include?(end_coords)
  end
end
