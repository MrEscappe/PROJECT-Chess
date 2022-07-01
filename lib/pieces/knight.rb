# frozen_string_literal: true

require_relative 'piece'

class Knight < Piece
  MOVES = [
    [1, 2],
    [-2, -1],
    [-1, 2],
    [2, -1],
    [1, -2],
    [-2, 1],
    [-1, -2],
    [2, 1]
  ].freeze

  def moves
    MOVES
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
    move.uniq
  end

  def piece_color
    @color == :white ? "\u2658" : "\u265E"
  end
end
