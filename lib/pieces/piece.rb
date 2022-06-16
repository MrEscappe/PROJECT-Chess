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
    loc = []

    moves.each do |e, v|
      current_r, current_c = location

      loop do
        current_r += e
        current_c += v
        position = [current_r, current_c]
        break unless board.in_bounds?(position)
        break unless ally?(position)

        loc << position if board.empty?(position)
        if enemy?(position)
          loc << position
          break
        end
      end
    end
    loc
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

# test enemy?
