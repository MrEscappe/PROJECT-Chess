# frozen_string_literal: true

require_relative 'translate_input'
require_relative 'title'

class Board
  attr_reader :board, :piece, :input

  def initialize
    title
    @grid = Array.new(8) { Array.new(8) { '    ' } }
    @input = TranslateInput.new
    render_board(@grid)
  end

  def render_board(grid)
    grid.reverse_each do |e|
      puts '-----+------+------+------+------+------+------+-----+'
      puts e.join(' | ')
    end
    puts '-----+------+------+------+------+------+------+-----+'
    puts '  a      b      c      d      e      f      g      h'
  end

  def update_grid(row, column, piece)
    @piece = piece
    @grid[row][column] = piece
    render_board(@grid)
  end
end

board = Board.new
