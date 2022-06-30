# frozen_string_literal: true

require_relative 'pieces'

class Piece
  attr_reader :color, :board
  attr_accessor :location

  include TranslateInput

  def initialize(board, location, color)
    @board = board
    @color = color
    @location = location
  end

  def available_moves
    # go through all possible moves and return an array of available moves, if the move is valid
    move = []
    moves.each do |move_vector|
      current_r = location[0]
      current_c = location[1]

      loop do
        current_r += move_vector[0]
        current_c += move_vector[1]
        position = [current_r, current_c]

        break unless board.in_bounds?(position)
        break if board[position].color == color

        move << position if board.empty?(position)

        if enemy?(position)
          move << position
          break
        end
      end
    end
    move.uniq
  end

  def enemy?(location)
    if board.in_bounds?(location) && board[location].is_a?(Pawn) && board[location].en_passant_flag == true &&
       board[location].color != color
      return true
    end

    board.in_bounds?(location) && board[location].color != color && !board.empty?(location)
  end

  # def ally?(location)
  #   board.pieces.each do |piece|
  #     if piece.is_a?(King) && piece.color != color
  #       piece.available_moves.each do |move|
  #         false if move == location
  #       end
  #     end
  #   end
  #   board.in_bounds?(location) && board[location].color == color
  # end

  # check enemy color

  def current_r
    location[0]
  end

  def current_c
    location[1]
  end
end
