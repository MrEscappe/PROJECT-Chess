# frozen_string_literal: true

require_relative './lib/board'
require_relative './lib/pieces/pieces'
require_relative 'translate_input'


class Game
  attr_reader :board, :player, :computer

  include TranslateInput
  def initialize
    @board = Board.new
    @player1 = Player.new
    @player2 = Player.new
    @current_player = @player1
    # @computer = Computer.new
  end

  def play
    board.place_pieces
    board.render_board
  end

  

  
end
