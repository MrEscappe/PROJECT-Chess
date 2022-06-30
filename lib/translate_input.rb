# frozen_string_literal: true

module TranslateInput
  attr_reader :row, :column

  def initialize
    @row = nil
    @column = nil
  end

  def translate(location)
    x = ''
    y = ''

    position = location.split('')
    letter = position[0]
    number = (position[1..]).join.to_i
    if (1..8).include?(number) && ('a'..'h').include?(letter)
      x = translate_column(letter)
      y = translate_row(number)
    else
      invalid_input
    end
    [convert_y(y), x]
  end

  # convert y to the corret row number for the board
  def convert_y(y)
    7 - y
  end

  def translate_back(input)
    translate_back_column(input[1]) + translate_back_row(input[0])
  end

  def loop_available_moves(input)
    move = []
    input.available_moves.each do |e|
      move << translate_back(e)
    end
    if move.empty?
      ' there are no available moves'
    else
      " the available moves are: #{move.uniq.join(', ')}"
    end
  end

  private

  def translate_row(input)
    @row = input.to_i - 1
  end

  def translate_column(input)
    @column = input.downcase.ord - 97
  end

  def invalid_input
    puts 'Please Input a valid position.'
  end

  # translate back with the correct row and column number

  def translate_back_row(input)
    (1..8).to_a.reverse[input].to_s
  end

  def translate_back_column(input)
    (input + 97).chr
  end
end
