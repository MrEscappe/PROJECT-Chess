# frozen_string_literal: true

require_relative 'piece'

class King < Piece
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

  def moves
    MOVES
  end

  def piece_color
    @color == :white ? "\u2654" : "\u265A"
  end

  def available_moves
    move = []

    moves.each do |move_vector|
      current_r, current_c = location

      current_r += move_vector[0]
      current_c += move_vector[1]
      position = [current_r, current_c]

      move << position if board.in_bounds?(position) && !ally?(position)

      move << position if enemy?(position)
    end
    move
  end 

  def castle(location); end

end
