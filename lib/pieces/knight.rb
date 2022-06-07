# frozen_string_literal: true

require_relative 'piece'

class Knight < Piece
  attr_accessor :moves, :grid
  
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

  def piece_color
    @color == :white ? "\u2658" : "\u265E"
  end
end
