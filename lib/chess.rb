class Chess
  def initialize(empty = false)
    @board = Board.new(empty)
    @turns = 0

    play
  end

  def play
    
    while true
      print_board
      play_turn

      ["black", "white"].each do |colour|
        if checkmate?(colour)
          puts("#{colour} has been checkmated!")
          return true
        elsif stalemate?(colour)
          puts("Stalemate!")
          return true
        elsif check?(colour)
          puts("#{colour} is in check")
        end
      end
    end
  end

  def play_turn
    player_colour = (@turns % 2 == 0) ? "white" : "black"
    move_input = get_valid_input(player_colour)
    until move_input
      move_input = get_valid_input(player_colour)
    end
    start_square = move_input[0..1]
    end_square = move_input[3..4]
    make_move(start_square, end_square)
    @turns += 1
  end

  def get_valid_input(player_colour)
    puts("Input #{player_colour}'s move")
    move_input = gets.chomp
    start_square = move_input[0..1]
    end_square = move_input[3..4]
    if not is_valid?(move_input)
      puts("Invalid entry format")
      return false
    elsif @board.grid[algebraic_translator(start_square)[0]][algebraic_translator(start_square)[1]].nil? or @board.grid[algebraic_translator(start_square)[0]][algebraic_translator(start_square)[1]].colour != player_colour
      puts("That is not your piece to move")
      return false
    elsif not valid_move?(start_square, end_square)
      puts("That is not a valid move")
      return false
    end
    return move_input
  end

  def is_valid?(input)
    return (input.length == 5 and "abcdefgh".include?(input[0]) and "12345678".include?(input[1]) and input[2] == " " and "abcdefgh".include?(input[3]) and "12345678".include?(input[4]))
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

  def any_moves?(colour)
    @board.grid.each_with_index do |row_list, row|
      row_list.each_with_index do |square, col|
        if not(@board.grid[row][col].nil?) and (@board.grid[row][col].colour() == colour) and (valid_moves(row,col) != [])
          return true
        end
      end
    end
    return false
  end

  def checkmate?(colour)
    if check?(colour) and not any_moves?(colour)
      return true
    else
      return false
    end
  end

  def stalemate?(colour)
    if not(check?(colour)) and not any_moves?(colour)
      return true
    else
      return false
    end
  end

  def valid_moves(row, col)
    return @board.grid[row][col].valid_moves([row,col], @board).select{|move| not(makes_check?([row,col], move))}
  end

  def valid_move?(start_square, end_square)
    start_coords = algebraic_translator(start_square)
    end_coords = algebraic_translator(end_square)

    return valid_moves(start_coords[0], start_coords[1]).include?(end_coords)
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
      #p(end_coords)
      @board.grid[start_coords[0]][start_coords[1]] = nil
      true
    else
      false
    end
  end
end