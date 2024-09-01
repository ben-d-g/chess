# frozen_string_literal: true

class Chess
  def initialize(empty = false)
    @board = Board.new(empty)
    @turns = 0

    play
  end

  def play
    loop do
      colour = @turns.even? ? 'white' : 'black'
      if checkmate?(colour)
        puts("#{colour} has been checkmated!")
        return true
      elsif stalemate?(colour)
        puts('Stalemate!')
        return true
      elsif check?(colour)
        puts("#{colour} is in check")
      end

      print_board
      return nil if play_turn == 'saved'
    end
  end

  def save_game
    File.open('save_game.dat', 'wb') do |file|
      Marshal.dump(@board, file)
    end
  end

  def load_game
    File.open('save_game.dat', 'rb') do |file|
      @board = Marshal.load(file)
    end
  end

  def play_turn
    player_colour = @turns.even? ? 'white' : 'black'
    move_input = get_valid_input(player_colour)
    move_input = get_valid_input(player_colour) until move_input
    return 'saved' if move_input == 'saved'

    unless (move_input == 'castled') || (move_input == 'loaded')
      start_square = move_input[0..1]
      end_square = move_input[3..4]
      make_move(start_square, end_square)
    end
    @turns += 1
  end

  def get_valid_input(player_colour)
    puts("Input #{player_colour}'s move")
    move_input = gets.chomp
    start_square = move_input[0..1]
    end_square = move_input[3..4]

    if move_input == 'save'
      save_game
      return 'saved'
    end

    if move_input == 'load'
      load_game
      return 'loaded'
    end

    # manually check for castles
    if (move_input == 'e1 g1') && @board.grid[0][4].is_a?(King) && (@board.grid[0][4].colour == 'white') && @board.grid[0][5].nil? && @board.grid[0][6].nil? && @board.grid[0][7].is_a?(Rook) && (@board.grid[0][7].colour == 'white')
      @board.grid[0][6] = King.new('white')
      @board.grid[0][5] = Rook.new('white')
      @board.grid[0][4] = nil
      @board.grid[0][7] = nil
      return 'castled'
    end

    if (move_input == 'e1 c1') && @board.grid[0][4].is_a?(King) && (@board.grid[0][4].colour == 'white') && @board.grid[0][3].nil? && @board.grid[0][2].nil? && @board.grid[0][1].nil? && @board.grid[0][0].is_a?(Rook) && (@board.grid[0][0].colour == 'white')
      @board.grid[0][2] = King.new('white')
      @board.grid[0][3] = Rook.new('white')
      @board.grid[0][0] = nil
      @board.grid[0][1] = nil
      @board.grid[0][4] = nil
      return 'castled'
    end

    if (move_input == 'e8 g8') && @board.grid[7][4].is_a?(King) && (@board.grid[7][4].colour == 'black') && @board.grid[7][5].nil? && @board.grid[7][6].nil? && @board.grid[7][7].is_a?(Rook) && (@board.grid[7][7].colour == 'black')
      @board.grid[7][6] = King.new('black')
      @board.grid[7][5] = Rook.new('black')
      @board.grid[7][4] = nil
      @board.grid[7][7] = nil
      return 'castled'
    end

    if (move_input == 'e8 c8') && @board.grid[7][4].is_a?(King) && (@board.grid[7][4].colour == 'black') && @board.grid[7][3].nil? && @board.grid[7][2].nil? && @board.grid[7][1].nil? && @board.grid[7][0].is_a?(Rook) && (@board.grid[7][0].colour == 'black')
      @board.grid[7][2] = King.new('black')
      @board.grid[7][3] = Rook.new('black')
      @board.grid[7][0] = nil
      @board.grid[7][1] = nil
      @board.grid[7][4] = nil
      return 'castled'
    end

    if !is_valid?(move_input)
      puts('Invalid entry format')
      return false
    elsif @board.grid[algebraic_translator(start_square)[0]][algebraic_translator(start_square)[1]].nil? || (@board.grid[algebraic_translator(start_square)[0]][algebraic_translator(start_square)[1]].colour != player_colour)
      puts('That is not your piece to move')
      return false
    elsif !valid_move?(start_square, end_square)
      puts('That is not a valid move')
      return false
    end
    move_input
  end

  def is_valid?(input)
    (input.length == 5 and 'abcdefgh'.include?(input[0]) and '12345678'.include?(input[1]) and input[2] == ' ' and 'abcdefgh'.include?(input[3]) and '12345678'.include?(input[4]))
  end

  attr_accessor :board

  def check?(colour)
    @board.grid.each_with_index do |row_list, row|
      row_list.each_with_index do |square, col|
        next if square.nil?

        square.valid_moves([row, col], @board).each do |move_square|
          if @board.grid[move_square[0]][move_square[1]].is_a?(King) && (@board.grid[move_square[0]][move_square[1]].colour == colour)
            return true
          end
        end
      end
    end
    false
  end

  def makes_check?(start_coords, end_coords)
    start_piece = @board.at(start_coords)
    end_piece = @board.at(end_coords)

    @board.grid[end_coords[0]][end_coords[1]] = start_piece
    @board.grid[start_coords[0]][start_coords[1]] = nil

    return_value = check?(@board.grid[end_coords[0]][end_coords[1]].colour)

    @board.grid[end_coords[0]][end_coords[1]] = end_piece
    @board.grid[start_coords[0]][start_coords[1]] = start_piece

    return_value
  end

  def any_moves?(colour)
    @board.grid.each_with_index do |row_list, row|
      row_list.each_with_index do |_square, col|
        if !@board.grid[row][col].nil? && (@board.grid[row][col].colour == colour) && (valid_moves(row,
                                                                                                   col) != [])
          return true
        end
      end
    end
    false
  end

  def checkmate?(colour)
    if check?(colour) && !any_moves?(colour)
      true
    else
      false
    end
  end

  def stalemate?(colour)
    if !check?(colour) && !any_moves?(colour)
      true
    else
      false
    end
  end

  def valid_moves(row, col)
    @board.grid[row][col].valid_moves([row, col], @board).reject { |move| makes_check?([row, col], move) }
  end

  def valid_move?(start_square, end_square)
    start_coords = algebraic_translator(start_square)
    end_coords = algebraic_translator(end_square)

    valid_moves(start_coords[0], start_coords[1]).include?(end_coords)
  end

  def print_board
    @board.grid.reverse.each do |row|
      row_string = ''
      row.each do |square|
        row_string += if square.nil?
                        '.'
                      else
                        square.get_piece
                      end
      end
      puts(row_string)
    end
  end

  def algebraic_translator(input_string)
    row = input_string[1].to_i - 1
    col = 'abcdefgh'.index(input_string[0])

    [row, col]
  end

  def make_move(start_square, end_square)
    start_coords = algebraic_translator(start_square)
    end_coords = algebraic_translator(end_square)

    if @board.grid[start_coords[0]][start_coords[1]].valid_move?(start_coords, end_coords,
                                                                 @board) && !makes_check?(start_coords, end_coords)
      @board.grid[end_coords[0]][end_coords[1]] = @board.at(start_coords)
      # p(end_coords)
      @board.grid[start_coords[0]][start_coords[1]] = nil
      if (@board.grid[end_coords[0]][end_coords[1]].colour == 'white') && @board.grid[end_coords[0]][end_coords[1]].is_a?(Pawn) && (end_coords[0] == 7)
        @board.grid[end_coords[0]][end_coords[1]] = Queen.new('white')
      elsif (@board.grid[end_coords[0]][end_coords[1]].colour == 'black') && @board.grid[end_coords[0]][end_coords[1]].is_a?(Pawn) && (end_coords[0]).zero?
        @board.grid[end_coords[0]][end_coords[1]] = Queen.new('black')
      end
      true
    else
      false
    end
  end
end
