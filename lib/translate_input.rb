# frozen_string_literal: true

module TranslateInput
  attr_reader :row, :column

  def initialize
    @row = nil
    @column = nil
  end

  def translate(location)
    position = location.split('')
    letter = position[0]
    number = (position[1..]).join.to_i
    if (1..8).include?(number) && ('a'..'h').include?(letter)
      translate_column(letter)
      translate_row(number)
    else
      invalid_input
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
end
