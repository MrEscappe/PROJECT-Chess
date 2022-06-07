# frozen_string_literal: true

require_relative 'piece'

class Rook < Piece
  attr_accessor :moves, :grid

  MOVES = [
    [0, 1],
    [0, -1],
    [1, 0],
    [-1, 0]
  ].freeze

  def initialize(grid, location, color)
    super(grid, location, color)
    @grid = grid
    @moves = MOVES
  end

  def piece_color
    @color == :white ? "\u2656" : "\u265C"
  end
end
