# frozen_string_literal: true

require_relative 'piece'

class Queen < Piece
  MOVES = [
    [-1, -1],
    [-1, 0],
    [-1, 1],
    [0, -1],
    [0, 1],
    [1, -1],
    [1, 0],
    [1, 1]
  ].freeze

  def moves
    MOVES
  end

  def piece_color
    @color == :white ? "\u2655" : "\u265B"
  end
end
