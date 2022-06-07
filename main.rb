# frozen_string_literal: true

require_relative './lib/board'
require_relative './lib/pieces/pieces'
require_relative './lib/pieces/piece'

b = Board.new
b.place_pieces
b.render_board

