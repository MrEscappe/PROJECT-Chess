# frozen_string_literal: true

require_relative 'board'

require_relative 'translate_input'
require_relative 'player'

class Game
  attr_reader :board, :players, :computer, :current_player, :current_player_color

  include TranslateInput
  def initialize
    @board = Board.start_board
    @players = Player.new
    @current_player = @players.p1
    @current_player_color = @players.color1
    # @computer = Computer.new
    board.render
  end

  def swap_players!
    if @current_player == @players.p1 && @current_player_color == @players.color1
      @current_player = @players.p2
      @current_player_color = @players.color2
    else
      @current_player = @players.p1
      @current_player_color = @players.color1
    end
  end

  def play 
    until board.checkmate? || board.stalemate?
      puts
      puts "#{current_player}, it's your turn, you are #{current_player_color} pieces."
      puts 'Please enter a move in the format of "a2 to a4" or "a7 to a5".'
      print '> '
      input = player_move
      loop do
        if board[translate(input[0])].color == current_player_color
          break
        else
          puts 'Please select a piece of your color, you are not allowed to move your opponent\'s pieces.'
          puts "#{current_player}, it's your turn, you are #{current_player_color} pieces."
          input = player_move
        end
      end
      @board.move(input[0], input[1])
      swap_players!
    end
  end

  def player_move
    input = gets.chomp.split(' to ')
    input[0]
    input[1]
    if move_format.match(input[0]) && move_format.match(input[1])
      input
    else
      puts 'Please enter a valid move.'
      print '> '
      player_move
    end
  end

  def move_format
    /^[a-h][1-8]$/
  end
end
