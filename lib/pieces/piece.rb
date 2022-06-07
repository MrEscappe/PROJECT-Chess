# frozen_string_literal: true

class Piece
  attr_accessor :color, :grid, :location

  def initialize(grid, location, color)
    @grid = grid
    @location = location
    @color = color
  end

  def available_moves
    loc = []

    moves.each do |e, v|
      current_r, current_c = location

      loop do
        current_r += e
        current_c += v
        position = [current_r, current_c]
        break unless grid.in_bounds?(position)

        loc << position if grid.empty?(position)
        if enemy?(position)
          loc << position
          break
        end
      end
    end
    loc
  end

  def enemy?(location)
    !grid[location] == '' && grid[location].color == color
  end

  def current_r
    location[0]
  end

  def current_c
    location[1]
  end
end
