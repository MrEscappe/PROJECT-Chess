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
    loc = []

    moves.each do |e, v|
      current_r, current_c = location
      current_r += e
      current_c += v

      position = [current_r, current_c]
      next unless board.in_bounds?(position)

      loc << position if board.empty?(position) || enemy?(position)
    end

    loc
  end

  def piece_color
    @color == :white ? "\u2658" : "\u265E"
  end
end
