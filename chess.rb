# frozen_string_literal: true

require_relative './lib/board'
require_relative './lib/pieces/pieces'
require_relative './lib/game'
require_relative './lib/player'

# board = Board.start_board
# board.render
game = Game.new
game.play
# game.pieces.each do |piece|
#     p piece.location
#     p piece.color
# end

# # game[[2, 1]] = Pawn.new(game, [2, 1], :white)
# game.play

# board[[4, 5]] = King.new(board, [4, 5], :black)
# board[[7, 3]] = Queen.new(board, [7, 3], :white)
# board.move('d1', 'e3')
# board.render
# board.move('f4', 'g3')
# board.move('g3', 'f3')
# game = Game.new
# game.play

# test bishop

# test all pawns on the board
# ('a'..'h').each do |column|
#     grid.move("#{column}2", "#{column}5")
# end
# grid.render
