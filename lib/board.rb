# frozen_string_literal: true

require_relative 'translate_input'
# require_relative 'title'
require_relative './pieces/pieces'
require_relative 'miscellaneous'

class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8, nil) }
  end

  def place_pieces
    place_pawns
    black_pieces
    white_pieces
  end

  def []=(position, piece)
    row, column = position
    grid[row][column] = piece
  end

  def [](position)
    row, column = position
    return '' if grid[row][column].nil?

    grid[row][column].piece_color
  end

  def in_bounds?(location)
    row, column = location
    grid.first.length
    grid.length
    (row < grid.length && column < grid.first.length && row >= 0 && column >= 0)
  end

  def empty?(location)
    row, column = location
    grid[row][column].nil?
  end

  def black_pieces
    @grid[0][0] = Rook.new(grid, [0, 0], :black)
    @grid[0][1] = Knight.new(grid, [0, 1], :black)
    @grid[0][2] = Bishop.new(grid, [0, 2], :black)
    @grid[0][3] = Queen.new(grid, [0, 3], :black)
    @grid[0][4] = King.new(grid, [0, 4], :black)
    @grid[0][5] = Bishop.new(grid, [0, 5], :black)
    @grid[0][6] = Knight.new(grid, [0, 6], :black)
    @grid[0][7] = Rook.new(grid, [0, 7], :black)
  end

  def white_pieces
    @grid[7][0] = Rook.new(grid, [7, 0], :white)
    @grid[7][1] = Knight.new(grid, [7, 1], :white)
    @grid[7][2] = Bishop.new(grid, [7, 2], :white)
    @grid[7][3] = Queen.new(grid, [7, 3], :white)
    @grid[7][4] = King.new(grid, [7, 4], :white)
    @grid[7][5] = Bishop.new(grid, [7, 5], :white)
    @grid[7][6] = Knight.new(grid, [7, 6], :white)
    @grid[7][7] = Rook.new(grid, [7, 7], :white)
  end

  def place_pawns
    8.times do |e|
      @grid[6][e] = Pawn.new(grid, [6, e], :white)
      @grid[1][e] = Pawn.new(grid, [1, e], :black)
    end
  end

  def update_board(input, piece)
    user_input = TranslateInput.new
    user_input.translate(input)
    @grid[user_input.row][user_input.column] = piece
    render_board
  end

  def render_board
    top_board
    numbers_rows
    bottom_board
  end

  def top_board
    puts '     a    b    c    d    e    f    g    h '
    puts '   ┌────┬────┬────┬────┬────┬────┬────┬────┐'
  end

  def numbers_rows
    (1..7).each do |number|
      display_rows(number)
      puts '   ├────┼────┼────┼────┼────┼────┼────┼────┤'
    end
    display_rows(8)
  end

  def bottom_board
    puts '   └────┴────┴────┴────┴────┴────┴────┴────┘'
    puts '     a    b    c    d    e    f    g    h '
  end

  def display_rows(number)
    square = number.even? ? 0 : 1
    print "#{9 - number}  "
    @grid[number - 1].each do |e|
      if e.nil?
        print square.even? ? '│    ' : "│#{'    '.bg_white}"
      else
        print square.even? ? "│ #{e.piece_color}  " : "│#{" #{e.piece_color}  ".bg_white}"
      end
      square += 1
    end
    puts '|'
  end
end

# board = Board.new
# board.place_pieces
# board.render_board
