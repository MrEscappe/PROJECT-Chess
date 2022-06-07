# frozen_string_literal: true

require_relative 'translate_input'

class Player
  attr_accessor :name

  include TranslateInput

  def initialize(name = 'Player')
    @name = get_name(name)
  end

  def get_name(name)
    puts "What is your name, #{name}?"
    name = gets.chomp
    if name.empty?
      puts 'You must enter a name.'
      get_name(name)
    else
      name
    end
  end

  def input_move
    puts "Where would you like to move #{name}?"
    location = input_user
    translate(location)
  end

  def input_user
    gets.chomp
  end
end
