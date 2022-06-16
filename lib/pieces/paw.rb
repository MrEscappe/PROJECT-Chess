# frozen_string_literal: true

require_relative 'pieces'
require_relative 'piece'

class Pawn < Piece
  attr_accessor :one_step, :two_step

  MOVES = [
    [0, 1],
    [0, 2]
  ].freeze

  def moves
    MOVES
  end

  def at_start_row?
    current_r == (color == :white ? 6 : 1)
  end

  def forward_direction
    color == :white ? -1 : 1
  end

  def available_moves
    loc = []

    @one_step = [current_r + forward_direction, current_c]
    loc << one_step if board.empty?(one_step) && !ally?(one_step)

    @two_step = [current_r + (forward_direction * 2), current_c]
    loc << two_step if board.empty?(two_step) && board.empty?(one_step) && at_start_row?

    loc.select { |move| board.in_bounds?(move) }

    # check for enemy diagonal moves

    diagonal_enemy.each { |e| loc << e }

    loc
  end

  def diagonal_enemy
    loc = []

    diagonal_right = [current_r + forward_direction, current_c + 1]
    diagonal_left = [current_r + forward_direction, current_c - 1]
    loc << diagonal_right if enemy?(diagonal_right) && board[diagonal_right].is_a?(Pawn)
    loc << diagonal_left if enemy?(diagonal_left) && board[diagonal_left].is_a?(Pawn)
    loc.select { |move| board.in_bounds?(move) }
    loc
  end

  def possible_en_passant
    # check if the pawn is on the same row as the enemy pawn
    # and if the pawn is one step away from the enemy pawn
    # and if the enemy pawn has just moved two steps

    # if so, return the location of the enemy pawn
    # if the enemy pawn has just moved two steps, set the en_passant flag to true
    # if not, set the en_passant flag to false

  end

  def piece_color
    @color == :white ? "\u2659" : "\u265F"
  end
end
