# frozen_string_literal: true

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
        break if !board.in_bounds?([current_r, current_c]) || board[[current_r, current_c]].color == color
        break if ally?([current_r, current_c])

        move << [current_r, current_c] if enemy?([current_r, current_c])
      end
    end
    move
  end

  def enemy?(location)
    board.in_bounds?(location) && board[location].color != color
  end

  def ally?(location)
    board.in_bounds?(location) && board[location].color == color
  end

  def current_r
    location[0]
  end

  def current_c
    location[1]
  end
end
