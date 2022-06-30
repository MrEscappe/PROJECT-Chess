# frozen_string_literal: true

module RenderBoard
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
      if e == is_a?(EmptyPiece)
        print square.even? ? '│    ' : "│#{'    '.bg_white}"
      else
        print square.even? ? "│ #{e.piece_color}  " : "│#{" #{e.piece_color}  ".bg_white}"
      end
      square += 1
    end
    puts '|'
  end

  # show history of moves at side of board

  def show_history; end
end
