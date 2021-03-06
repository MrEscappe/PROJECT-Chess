# frozen_string_literal: true

require_relative 'piece'

class Bishop < Piece
  MOVES = [
    [1, 1],
    [1, -1],
    [-1, 1],
    [-1, -1]
  ].freeze

  def moves
    MOVES
  end

  def piece_color
    @color == :white ? "\u2657" : "\u265D"
  end
end
