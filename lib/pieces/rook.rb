# frozen_string_literal: true

require_relative 'piece'

class Rook < Piece
  attr_accessor :has_moved

  MOVES = [
    [0, 1],
    [0, -1],
    [1, 0],
    [-1, 0]
  ].freeze

  def initialize(board, location, color)
    super(board, location, color)
    @has_moved = false
  end

  def moves
    MOVES
  end

  def piece_color
    @color == :white ? "\u2656" : "\u265C"
  end
end
