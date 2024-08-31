class Piece
  def valid_moves(coords, board)
    move_list = []
    
    # Single-step moves
    @moves[:once].each do |move|
      new_coords = [coords[0] + move[0], coords[1] + move[1]]
      if new_coords.all? { |c| c.between?(0, 7) }
        move_list.push(new_coords) if board.grid[new_coords[0]][new_coords[1]].nil?
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
          if board.grid[new_coords[0]][new_coords[1]].colour != @colour
            move_list.push(new_coords)
          end
          break
        end
        counter += 1
      end
    end
    
    move_list
  end

  def valid_move?(start_coords, end_coords, board)
    return valid_moves(start_coords, board).include?(end_coords)
  end
end
