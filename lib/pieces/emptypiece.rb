# frozen_string_literal: true

class EmptyPiece
  def piece_color
    ' '
  end

  def color; end

  def available_moves
    []
  end
end
