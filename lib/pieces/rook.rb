# frozen_string_literal: true

require_relative 'piece'

class Rook < Piece 

  MOVES = [
    [0, 1],
    [0, -1],
    [1, 0],
    [-1, 0]
  ].freeze

  def moves
    MOVES
  end

  def piece_color
    @color == :white ? "\u2656" : "\u265C"
  end
end
