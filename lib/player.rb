# frozen_string_literal: true

require_relative 'translate_input'

class Player
  attr_accessor :p1, :p2, :color1, :color2

  include TranslateInput

  def initialize
    @p1 = get_name
    puts "Hello #{@p1}!"
    puts
    @color1 = get_color
    puts ''
    @p2 = get_name
    puts "Hello #{@p2}!"
    puts
    @color2 = get_color
    sleep 3
  end

  def get_name
    puts 'What is your name?'
    name = gets.chomp.to_s.capitalize
    until name.length.positive?
      puts 'Please enter a valid name.'
      name = gets.chomp.to_s.capitalize
    end
    name
  end

  def get_color
    if @color1 == :white
      puts "#{@p2}, your pieces will be black."
      return @color2 = :black
    end
    if @color1 == :black
      puts "#{@p2}, your pieces will be white."
      return @color2 = :white
    end

    return if @color1 == :white || @color1 == :black

    color = get_color_input
    until %w[white black].include?(color)
      puts 'Please enter a valid color.'
      color = get_color_input
    end

    if color == 'white'
      :white
    else
      :black
    end
  end

  def get_color_input
    puts 'What color would you like your pieces to be?'
    puts 'Enter white or black.'
    print '> '
    color = gets.chomp.to_s.downcase
    until %w[white black].include?(color)
      puts 'Please enter a valid color.'
      color = gets.chomp.to_s.downcase
    end
    color
  end
end
