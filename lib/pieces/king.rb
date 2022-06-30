# frozen_string_literal: true

require_relative 'piece'
require_relative 'pieces'
# require_relative '../board'

class King < Piece
  attr_accessor :has_moved

  MOVES = [
    [1, 1],
    [1, 0],
    [1, -1],
    [0, 1],
    [0, -1],
    [-1, 1],
    [-1, 0],
    [-1, -1]
  ].freeze

  def initialize(board, location, color)
    super(board, location, color)
    @has_moved = false
  end

  def moves
    MOVES
  end

  def piece_color
    @color == :white ? "\u2654" : "\u265A"
  end

  def available_moves
    move = []

    moves.each do |move_vector|
      current_r, current_c = location

      current_r += move_vector[0]
      current_c += move_vector[1]
      position = [current_r, current_c]

      move << position if board.in_bounds?(position) && board.empty?(position)

      move << position if enemy?(position)
    end
    possible_castle.each { |e| move << e }
    move.uniq
  end

  def possible_castle
    return [] if has_moved == true

    move = []

    x = color == :white ? 7 : 0

    if board[[x, 0]].is_a?(Rook) && board[[x, 0]].has_moved == false && (board.empty?([x, 1]) && board.empty?([x, 2]) &&
       board.empty?([x, 3]))
      possible = true

      board.pieces.each.reject { |e| e.color == color }.each do |piece|
        piece.available_moves.each do |moves|
          possible = false if moves == [x, 2]
        end
      end
      move << [x, 2] if possible == true
    end

    if board[[x, 7]].is_a?(Rook) && board[[x, 7]].has_moved == false && (board.empty?([x, 5]) && board.empty?([x, 6]))
      possible = true
      board.pieces.each.reject { |e| e.color == color }.each do |piece|
        piece.available_moves.each do |moves|
          possible = false if moves == [x, 6]
        end
      end
      move << [x, 6] if possible == true
    end
    move
  end
end
