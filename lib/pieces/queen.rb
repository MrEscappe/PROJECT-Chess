# frozen_string_literal: true

require_relative 'piece'

class Queen < Piece
  attr_accessor :moves, :grid

  MOVES = [
    [1, 1],
    [1, -1],
    [-1, 1],
    [-1, -1],
    [0, 1],
    [0, -1],
    [1, 0],
    [-1, 0]
  ].freeze

  def initialize(grid, location, color)
    super(grid, location, color)
    @moves = MOVES
  end

  def piece_color
    @color == :white ? "\u2655" : "\u265B"
  end
end
