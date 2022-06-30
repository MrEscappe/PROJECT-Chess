# frozen_string_literal: true

require_relative 'pieces'
require_relative 'piece'

class Pawn < Piece
  attr_accessor :one_step, :two_step, :two_moves, :moves_count, :en_passant_flag

  MOVES = [
    [0, 1],
    [0, 2]
  ].freeze

  def initialize(board, location, color)
    super(board, location, color)
    @moves_count = 0
    @en_passant_flag = false
  end

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
    loc << one_step if board.empty?(one_step)

    @two_step = [current_r + (forward_direction * 2), current_c]
    loc << two_step if board.empty?(two_step) && board.empty?(one_step) && at_start_row?

    loc.select { |move| board.in_bounds?(move) }

    # check for enemy diagonal moves

    diagonal_enemy.each { |e| loc << e }
    possible_en_passant.each { |e| loc << e }

    loc.uniq
  end

  def diagonal_enemy
    loc = []

    diagonal_right = [current_r + forward_direction, current_c + 1]
    diagonal_left = [current_r + forward_direction, current_c - 1]
    loc << diagonal_right if enemy?(diagonal_right) && !board.empty?(diagonal_right)
    loc << diagonal_left if enemy?(diagonal_left) && !board.empty?(diagonal_left)
    loc.select { |move| board.in_bounds?(move) }
    loc
  end

  def possible_en_passant
    loc = []
    # check if the pawn is on the same row as the enemy pawn
    horizontal_right = [current_r, current_c + 1]
    horizontal_left = [current_r, current_c - 1]

    if enemy?(horizontal_right) && !board.empty?(horizontal_right) && board[horizontal_right].is_a?(Pawn) &&
       board[horizontal_right].en_passant_flag == true &&
       board[horizontal_right].moves_count <= 4

      loc << [current_r + forward_direction, current_c - 1]
    end
    if enemy?(horizontal_left) && !board.empty?(horizontal_left) && board[horizontal_left].is_a?(Pawn) &&
       board[horizontal_left].en_passant_flag == true &&
       board[horizontal_left].moves_count <= 4

      loc << [current_r + forward_direction, current_c - 1]
    end
    loc.select { |move| board.in_bounds?(move) }
    loc
  end

  def piece_color
    @color == :white ? "\u2659" : "\u265F"
  end
end
