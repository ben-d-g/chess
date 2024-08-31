class Chess
  def initialize
    @board = Board.new
  end

  attr_accessor :board

  def algebraic_translator(input_string)
    row = input_string[1].to_i - 1
    col = "abcdefgh".index(input_string[0])

    return [row, col]
  end

  def make_move(start_square, end_square)
    start_coords = algebraic_translator(start_square)
    end_coords = algebraic_translator(end_square)

    if @board.grid[start_coords[0]][start_coords[1]].valid_move?(start_coords, end_coords, @board)
      @board.grid[end_coords[0]][end_coords[1]] = @board.at(start_coords)
      p(end_coords)
      @board.grid[start_coords[0]][start_coords[1]] = nil
      true
    else
      false
    end
  end
end