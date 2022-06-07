# frozen_string_literal: true

require_relative 'piece'

class King < Piece
  attr_accessor :moves, :grid

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

  def initialize(grid, location, color)
    super(grid, location, color)
    @moves = MOVES
  end

  def available_moves
    loc = []

    moves.each do |e, v|
      current_r, current_c = location
      current_r += e
      current_c += v

      position = [current_r, current_c]
      next unless grid.in_bounds?(position)

      loc << position if grid.empty?(position) || enemy?(position)
    end
    loc
  end

  def castle(location); end

  def piece_color
    @color == :white ? "\u2654" : "\u265A"
  end
end
