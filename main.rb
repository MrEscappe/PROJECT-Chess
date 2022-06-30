# frozen_string_literal: true

require_relative './lib/board'
require_relative './lib/pieces/pieces'
require_relative './lib/game'

game = Game.new

# test bishop

# test all pawns on the board
# ('a'..'h').each do |column|
#     grid.move("#{column}2", "#{column}5")
# end
# grid.render
