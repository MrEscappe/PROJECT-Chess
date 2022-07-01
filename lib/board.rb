# frozen_string_literal: true

require_relative 'translate_input'
require_relative './pieces/pieces'
require_relative 'miscellaneous'
require_relative 'render_board'

class Board
  attr_accessor :grid

  include RenderBoard
  include TranslateInput

  def self.start_board
    board = new

    # Place pawns
    8.times do |e|
      board[[6, e]] = Pawn.new(board, [6, e], :white)
      board[[1, e]] = Pawn.new(board, [1, e], :black)
    end

    # White pieces
    board[[7, 0]] = Rook.new(board, [7, 0], :white)
    board[[7, 1]] = Knight.new(board, [7, 1], :white)
    board[[7, 2]] = Bishop.new(board, [7, 2], :white)
    board[[7, 3]] = Queen.new(board, [7, 3], :white)
    board[[7, 4]] = King.new(board, [7, 4], :white)
    board[[7, 5]] = Bishop.new(board, [7, 5], :white)
    board[[7, 6]] = Knight.new(board, [7, 6], :white)
    board[[7, 7]] = Rook.new(board, [7, 7], :white)

    # # Black pieces
    board[[0, 0]] = Rook.new(board, [0, 0], :black)
    board[[0, 1]] = Knight.new(board, [0, 1], :black)
    board[[0, 2]] = Bishop.new(board, [0, 2], :black)
    board[[0, 3]] = Queen.new(board, [0, 3], :black)
    board[[0, 4]] = King.new(board, [0, 4], :black)
    board[[0, 5]] = Bishop.new(board, [0, 5], :black)
    board[[0, 6]] = Knight.new(board, [0, 6], :black)
    board[[0, 7]] = Rook.new(board, [0, 7], :black)
    board
  end

  def initialize
    @grid = Array.new(8) { Array.new(8, EmptyPiece.new) }
  end

  def []=(position, piece)
    row, column = position
    grid[row][column] = piece
  end

  def [](position)
    row, column = position
    grid[row][column]
  end

  def in_bounds?(location)
    row, column = location
    (row < grid.length && column < grid.first.length && row >= 0 && column >= 0)
  end

  def empty?(location)
    return unless in_bounds?(location) == true

    row = location[0]
    column = location[1]
    grid[row][column].instance_of?(EmptyPiece)
  end

  def pieces
    grid.flatten.reject { |e| e.instance_of?(EmptyPiece) }
  end

  def clone
    new_board = Board.new
    pieces.each do |piece|
      new_piece = piece.class.new(new_board, piece.location, piece.color)
      new_board[piece.location] = new_piece
    end
    new_board
  end

  def render
    system 'clear'
    render_board
  end

  def move?(start_pos, end_pos)
    input_start = translate(start_pos)
    input_end = translate(end_pos)
    piece = self[input_start]
    if start_pos == end_pos
      puts "You can't move to the same location!"
      puts 'Please input a valid move.'
      return false
    elsif empty?(input_start)
      puts "There is no piece at #{start_pos}."
      puts 'Please input a valid move.'
      return false
    end

    unless in_bounds?(input_end)
      puts
      puts 'Your input is out of bounds, please input a valid position.'
    end

    if piece.available_moves.include?(input_end)
      # Puts the flag for en_passant on the pawns
      if piece.is_a?(Pawn) && piece.moves_count <= 4
        piece.moves_count = + 1
        en_passant?(input_end, piece)
      end

      en_passant_enemy_color(input_start, input_end)

      if en_passant?(input_end, piece) == true
        en_passant_enemy_color(input_start, input_end)
        self[input_start] = EmptyPiece.new
        self[input_end] = piece
        piece.location = input_end
        return true
      end

      if piece.is_a?(King)
        self[input_start] = EmptyPiece.new
        move_rook_castle(input_start, input_end, piece)
        castle_flag?(piece)
        self[input_end] = piece
        piece.location = input_end
        return true
      end

      self[input_start] = EmptyPiece.new
      castle_flag?(piece)
      self[input_end] = piece
      piece.location = input_end
      true
    elsif !piece.available_moves.include?(input_end)
      puts
      puts "invalid move for the #{piece.class},#{loop_available_moves(piece)}."
      false
    end
  end

  def promotion?(input_end)
    @grid[input_end[0]][input_end[1]].is_a?(Pawn) && [0, 7].include?(input_end[0])
  end

  def castle_flag?(piece)
    if piece.is_a?(Rook)
      piece.has_moved = true
      true
    end

    if piece.is_a?(King)
      piece.has_moved = true
      true
    end
  end

  def move_rook_castle(input_start, input_end, piece)
    return unless [[7, 6], [7, 2], [0, 2], [0, 6]].include?(input_end)
    return unless piece.is_a?(King) && piece.has_moved == false

    if grid[input_start[0]][input_start[1] + 3].is_a?(Rook) && [[7, 6], [0, 6]].include?(input_end)
      rook = self[[input_start[0], input_start[1] + 3]]
      self[[input_start[0], input_start[1] + 3]] = EmptyPiece.new
      self[[input_start[0], input_start[1] + 1]] = rook
      rook.location = [input_start[0], input_start[1] + 1]
      rook.has_moved = true
      piece.has_moved = true
      true
    end

    if grid[input_start[0]][input_start[1] - 4].is_a?(Rook) && [[7, 2], [0, 2]].include?(input_end)
      rook = self[[input_start[0], input_start[1] - 4]]
      self[[input_start[0], input_start[1] - 4]] = EmptyPiece.new
      self[[input_start[0], input_start[1] - 1]] = rook
      rook.location = [input_start[0], input_start[1] - 1]
      rook.has_moved = true
      piece.has_moved = true
      true
    end
  end

  def en_passant?(input_end, piece)
    return unless piece.is_a?(Pawn)

    end_x, _end_y = input_end
    if piece.at_start_row? == false
      piece.en_passant_flag = false
      false
    end
    if piece.at_start_row? && [3, 4].include?(end_x)
      piece.en_passant_flag = true
      true
    end
  end

  def en_passant_enemy_color(input_start, input_end)
    return unless grid[input_end[0]][input_end[1]].is_a?(Pawn)

    return false if grid[input_end[0] + 1][input_end[1]] == grid[input_start[0]][input_start[1]]

    return false unless (grid[input_end[0] + 1][input_end[1]].is_a?(Pawn) ||
                        grid[input_end[0] - 1][input_end[1]].is_a?(Pawn)) &&
                        (grid[input_end[0] + 1][input_end[1]].en_passant_flag == true ||
                        grid[input_end[0] - 1][input_end[1]].en_passant_flag == true)

    end_r, end_c = input_end
    start_r, start_c = input_start

    grid[end_r - 1][end_c] = EmptyPiece.new if grid[start_r][start_c + 1].color == :white

    grid[end_r + 1][end_c] = EmptyPiece.new if grid[start_r][start_c - 1].color == :black
  end

  def king_check?(input_end, piece)
    return false unless piece.is_a?(King) && king_self_check?(input_end, piece.color)

    puts 'You cannot move your king into check.'
    true
  end

  def king_self_check?(end_pos, color)
    pieces.reject { |piece| piece.color == color }.each do |piece|
      piece.available_moves.each do |move|
        return true if move == end_pos
      end
    end
    false
  end

  def in_check?(color)
    check = false

    pieces.reject { |piece| piece.color == color }.each do |piece|
      piece.available_moves.each do |move|
        return check = true if self[move].is_a?(King)
      end
    end
    check
  end

  def checkmate?(color)
    safe = []
    return unless in_check?(color)

    pieces.select { |piece| piece.color == color }.each do |piece|
      piece.available_moves.each do |move|
        # if the move saves the king from check then add it to the safe array
        clone_board = clone
        move_start = translate_back(piece.location)
        move_end = translate_back(move)
        safe << move if clone_board.move?(move_start, move_end) == true && (clone_board.in_check?(color) == false)
      end
    end
    safe == []
  end

  def stalemate?(color)
    # the king is not in check, but no piece can be moved without putting the king in check, so it's a stalemate
    stalemate = []
    return if in_check?(color)

    pieces.select { |piece| piece.color == color }.each do |piece|
      # next unless piece.is_a?(King)
      piece.available_moves.each do |move|
        stalemate << move if king_self_check?(move, color) == false
      end
    end
    stalemate.uniq == []
  end
end

