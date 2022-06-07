# frozen_string_literal: true

class Board
  attr_reader :board, :selected_chess, :loser

  include Display

  def initialize
    # Row is counted from top to bottom, and column left to right.
    # "" is empty block on board, and nil will be out of board.
    @board = Array.new(8) { Array.new(8) { '' } }
    @selected_chess = ''
    @loser = ''
  end

  def initialize_board
    initialize_row(0)
    initialize_row(1)
    initialize_row(6)
    initialize_row(7)
  end

  def initialize_row(row_index)
    case row_index
    when 0
      @board[0] = [
        Rook.new('black', [0, 0]),
        Knight.new('black', [0, 1]),
        Bishop.new('black', [0, 2]),
        Queen.new('black', [0, 3]),
        King.new('black', [0, 4]),
        Bishop.new('black', [0, 5]),
        Knight.new('black', [0, 6]),
        Rook.new('black', [0, 7])
      ]
    when 1
      8.times do |column|
        @board[1][column] = Pawn.new('black', [1, column])
      end
    when 6
      8.times do |column|
        @board[6][column] = Pawn.new('white', [6, column])
      end
    when 7
      @board[7] = [
        Rook.new('white', [7, 0]),
        Knight.new('white', [7, 1]),
        Bishop.new('white', [7, 2]),
        Queen.new('white', [7, 3]),
        King.new('white', [7, 4]),
        Bishop.new('white', [7, 5]),
        Knight.new('white', [7, 6]),
        Rook.new('white', [7, 7])
      ]
    end
  end

  # Subfunction of select_chess
  def get_chess(faction, input, player)
    # Judge whether computer or human
    array = convert_input(input) if player.identity == 'human'
    array = input if player.identity == 'computer'
    chess = @board[array[0]][array[1]]
    if chess != '' && chess.color == faction && chess.movable?(@board)
      @selected_chess = chess
      true
    else
      false
    end
  end

  # Subfunction of move_chess
  def take_chess(input, player)
    # Judge whether computer or human
    array = convert_input(input) if player.identity == 'human'
    array = input if player.identity == 'computer'
    space = @selected_chess.movable_space
    if space.include?([array[0], array[1]])
      get_result(array, player)
      @selected_chess = ''
      true
    else
      false
    end
  end

  def get_result(array, player)
    old_row = @selected_chess.location[0]
    old_column = @selected_chess.location[1]
    new_row = array[0]
    new_column = array[1]
    promotion = @selected_chess.has_promotion

    if (promotion && new_row.zero?) || (promotion && new_row == 7)
      faction = @selected_chess.color
      range = %w[b k r q]
      puts promotion_hint
      # Judge whether computer or human
      input = gets.chomp if player.identity == 'human'
      input = player.decide_promotion if player.identity == 'computer'

      until range.include?(input)
        puts input_error
        input = gets.chomp
      end
      @loser = @board[new_row][new_column].color if @board[new_row][new_column].instance_of? King
      new_chess = get_new_chess(input, new_row, new_column, faction)
      @board[new_row][new_column] = new_chess
    else
      @loser = @board[new_row][new_column].color if @board[new_row][new_column].instance_of? King
      @board[new_row][new_column] = @selected_chess
      @selected_chess.location = [new_row, new_column]
    end
    @board[old_row][old_column] = ''
  end

  def get_new_chess(input, row, column, color)
    location = [row, column]
    case input
    when 'b'
      new_chess = Bishop.new(color, location)
    when 'k'
      new_chess = King.new(color, location)
    when 'r'
      new_chess = Rook.new(color, location)
    when 'q'
      new_chess = Queen.new(color, location)
    else
      puts 'Error'
    end
    new_chess
  end

  def convert_input(input)
    array = input.split('').reverse
    array[0] = (8 - array[0].to_i).to_i
    array[1] = convert_char(array[1]).to_i
    array
  end

  def convert_char(input)
    case input
    when 'a'
      '0'
    when 'b'
      '1'
    when 'c'
      '2'
    when 'd'
      '3'
    when 'e'
      '4'
    when 'f'
      '5'
    when 'g'
      '6'
    when 'h'
      '7'
    else
      '!'
    end
  end

  # display board in the terminal
  def show_board
    @board.each_with_index do |columns, row_index|
      print "\e[36m  #{8 - row_index} \e[0m"
      columns.each_with_index do |position, column_index|
        update_borad(position, column_index, row_index)
      end
      puts ''
    end
    puts "\e[36m    a b c d e f g h \e[0m"
  end

  def update_borad(position, column_index, row_index)
    background = get_background(column_index, row_index)

    if selected_position?(column_index, row_index)
      print "\e[46#{position.push_unicode} \e[0m"
    elsif position != '' && potential_movement?(column_index, row_index)
      print "\e[41#{position.push_unicode} \e[0m"
    elsif potential_movement?(column_index, row_index)
      print "\e[41m  \e[0m"
    elsif position != ''
      print "\e[#{background}#{position.push_unicode} \e[0m"
    elsif print "\e[#{background}m  \e[0m"
    end
  end

  def get_background(column_index, row_index)
    case row_index % 2
    when 0
      return '47' if column_index.even?
      return '100' if column_index.odd?
    when 1
      return '100' if column_index.even?
      return '47' if column_index.odd?
    else
      puts 'Error!'
    end
  end

  def selected_position?(column_index, row_index)
    return false if @selected_chess == ''
    return true if @selected_chess.location == [row_index, column_index]
  end

  def potential_movement?(column_index, row_index)
    co_ord = [row_index, column_index]
    return false if @selected_chess == ''
    return true if @selected_chess.movable_space.include?(co_ord)
  end
end

d
