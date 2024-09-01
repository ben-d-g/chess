class Chess
  def initialize(empty = false)
    @board = Board.new(empty)
    @turns = 0

    #play
  end

  def play
    print_board
    make_move("e2","e4")
    print_board
  end

  attr_accessor :board

  def check?(colour)
    @board.grid.each_with_index do |row_list, row|
      row_list.each_with_index do |square, col|
        unless square.nil?
          square.valid_moves([row, col], @board).each do |move_square|
            return true if @board.grid[move_square[0]][move_square[1]].is_a?(King) and @board.grid[move_square[0]][move_square[1]].colour == colour
          end
        end
      end
    end
    return false
  end

  def makes_check?(start_coords, end_coords)
    start_piece = @board.at(start_coords)
    end_piece = @board.at(end_coords)

    @board.grid[end_coords[0]][end_coords[1]] = start_piece
    @board.grid[start_coords[0]][start_coords[1]] = nil

    return_value = check?(@board.grid[end_coords[0]][end_coords[1]].colour)

    @board.grid[end_coords[0]][end_coords[1]] = end_piece
    @board.grid[start_coords[0]][start_coords[1]] = start_piece

    return return_value
  end

  def print_board
    @board.grid.reverse.each do |row|
      row_string = ""
      row.each do |square|
        if square.nil?
          row_string += "."
        else
          row_string += square.get_piece
        end
      end
      puts(row_string)
    end
  end

  def algebraic_translator(input_string)
    row = input_string[1].to_i - 1
    col = "abcdefgh".index(input_string[0])

    return [row, col]
  end

  def make_move(start_square, end_square)
    start_coords = algebraic_translator(start_square)
    end_coords = algebraic_translator(end_square)

    if @board.grid[start_coords[0]][start_coords[1]].valid_move?(start_coords, end_coords, @board) and not(makes_check?(start_coords, end_coords))
      @board.grid[end_coords[0]][end_coords[1]] = @board.at(start_coords)
      p(end_coords)
      @board.grid[start_coords[0]][start_coords[1]] = nil
      true
    else
      false
    end
  end
end