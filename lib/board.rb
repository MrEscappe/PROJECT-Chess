# frozen_string_literal: true

require_relative 'translate_input'
# require_relative 'title'
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

    # Black pieces
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
    @grid = Array.new(8) { Array.new(8, EmptyPiece.instance) }
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
    row = location[0]
    column = location[1]
    grid[row][column] == EmptyPiece.instance
  end

  def render
    system 'clear'
    render_board
  end

  def move(start_pos, end_pos)
    if start_pos == end_pos
      puts "You can't move to the same location!"
      puts 'Please input a valid move.'
      return false
    end
    input_start = translate(start_pos)
    input_end = translate(end_pos)
    piece = self[input_start]

    # check if the input comes from the king and if it is in check
    return false if king_check?(input_end, piece) == false

    unless in_bounds?(input_end)
      render
      puts
      puts 'Your input is out of bounds, please input a valid position.'
    end

    if piece.available_moves.include?(input_end)
      self[input_start] = EmptyPiece.instance
      self[input_end] = piece
      piece.location = input_end
      render
    elsif !piece.available_moves.include?(input_end)
      render
      puts
      puts "invalid move for the #{piece.class},#{loop_available_moves(piece)}."
    end
  end

  def pieces
    grid.flatten.reject { |e| e == EmptyPiece.instance }
  end

  def king_check?(input_end, piece)
    return unless piece.is_a?(King) && king_self_check?(input_end, piece.color)

    safe_moves = []
    puts
    puts "You can't put your king in check!"
    # show the available moves for the king excluding the move that would put him in check
    piece.available_moves.each do |move|
      safe_moves << translate_back(move) if move != input_end
    end
    puts "The available moves for king are: #{safe_moves.uniq.join(', ')}"
    false
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
        check = true if self[move].is_a?(King)
      end
    end
    check
  end

  def checkmate?(color)
    return false unless in_check?(color)
  end

  def stalemate?
    false
  end
end
