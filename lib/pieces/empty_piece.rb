# frozen_string_literal: true

require 'singleton'

class EmptyPice
  include Singleton
  def piece_color
    ' '
  end

  def color; end

  def available_moves
    []
  end
end
