# frozen_string_literal: true

require_relative 'piece'

class Pawn < Piece
  attr_accessor :moves, :grid

  MOVES = [
    [0, 1],
    [0, 2]
  ].freeze

  def initialize(grid, location, color)
    super(grid, location, color)
    @moves = MOVES
  end

  def forward_direction
    color == :white ? 1 : -1
  end

  def available_moves
    loc = []

    one_step = [current_r + forward_direction, current_c]
    loc << one_step if grid.empty?(one_step)

    two_step = [current_r + (forward_direction * 2), current_c]
    loc << two_step if grid.empty?(two_step) && grid.empty?(one_step)

    # enemy diagonals
    diagonal_right = [current_r + forward_direction, current_c + 1]
    diagonal_left = [current_r + forward_direction, current_c - 1]
    loc << diagonal_right if enemy?(diagonal_right)
    loc << diagonal_left if enemy?(diagonal_left)

    moves.select { |move| grid.in_bounds?(move) }
  end

  def piece_color
    @color == :white ? "\u2659" : "\u265F"
  end
end
