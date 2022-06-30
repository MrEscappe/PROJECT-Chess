# frozen_string_literal: true

require_relative 'board'
# require_relative 'title'
require_relative 'translate_input'
require_relative 'player'
require_relative 'save'

class Game
  attr_reader :board, :players, :computer, :current_player, :current_player_color, :round_one, :game_instance

  include SaveLoad
  include TranslateInput
  def initialize
    # title = Title.new
    @board = Board.start_board
    # get_input
    @players = Player.new
    @current_player = @players.p1
    @current_player_color = @players.color1
    # @computer = Computer.new
    @round_one = true
    @game_instance = self
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
    if @current_player_color == :black && @round_one == true
      swap_players!
      @round_one = false
    end

    board.render

    until is_checkmate?(current_player_color) == true || is_stalemate?(current_player_color) == true
      puts
      puts "#{current_player}, it's your turn, you are #{current_player_color} pieces."
      current_player_in_check?
      input = player_move

      loop do
        break if board[translate(input[0])].color == current_player_color

        puts "Please select a piece of your color, you are not allowed to move your opponent's pieces."
        puts "#{current_player}, it's your turn, you are #{current_player_color} pieces."
        input = player_move
      end

      if move(input) == true
        pawn_promotion(current_player_color, translate(input[1]))
        swap_players!
        board.render
      end
    end
  end

  def move(input)
    # return false if current_player_in_check? == true

    board.move?(input[0], input[1])
  end

  def pawn_promotion(color, input_end)
    if board.promotion?(input_end) == true
      puts 'What piece you choose to upgrade your pawn?'
      puts 'Queen(Q), Rook(R), Bishop(B), Knight(K)'
      puts
      print '> '
      input = ''
      until %w[q r b k].include?(input)
        input = gets.chomp.downcase
        case input
        when 'q'
          @board[input_end] = Queen.new(@board, input_end, color)
        when 'r'
          @board[input_end] = Rook.new(@board, input_end, color)
        when 'b'
          @board[input_end] = Bishop.new(@board, input_end, color)
        when 'k'
          @board[input_end] = Knight.new(@board, input_end, color)
        else
          puts 'Please enter one of the options'
          puts 'Queen(Q), Rook(R), Bishop(B), Knight(K)'
        end
      end
    end
  end

  def is_checkmate?(color)
    if board.checkmate?(color) == true
      puts "Game over, #{color} is checkmated!"

      game_over
    else
      false
    end
  end

  def is_stalemate?(color)
    if board.stalemate?(color) == true
      puts "Game over, it's stalemate!"

      game_over
    else
      false
    end
  end

  # check if the move comes from the king and the end position puts the king in check.
  def in_check_move?(input)
    @board.king_check?(translate(input[1]), current_piece(input[0]))
  end

  def current_piece(input)
    @board[translate(input)]
  end

  def current_player_in_check?
    if board.in_check?(current_player_color)
      puts
      puts "#{current_player}, you are in check!"
      true
    else
      false
    end
  end

  def player_move
    puts 'Please enter a move in the format of "a2 to a4" or "a7 to a5", or enter "resign" to resign the game.'
    puts
    print '> '
    input = get_input

    if move_format.match(input[0]) && move_format.match(input[1])
      if in_check_move?(input)
        player_move
      else
        input
      end
    else
      puts 'Please enter a valid move.'
      player_move
    end
  end

  def game_over
    puts
    play_again?
  end

  def play_again?
    puts 'Do you want to play again? (Y/N)'
    input = ''
    until %w[y n].include?(input)
      input = gets.chomp.downcase
      case input
      when 'y'
        system 'clear'
        Game.new.play
      when 'n'
        exit
      else
        puts 'Please enter either Y or N.'
      end
    end
  end

  def get_input
    input = gets.chomp

    case input
    when 'resign'
      puts "The #{current_player} resigns!"
      game_over
    when 'save'
      save
    when 'load'
      load_game
    end

    input.split(' to ')
  end

  def move_format
    /^[a-h][1-8]$/
  end

  def save
    save_game(@game_instance)
    exit
  end
end

# game = Game.new

# game.save
