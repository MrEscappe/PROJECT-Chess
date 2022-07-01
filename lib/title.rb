# frozen_string_literal: true

require_relative 'game'
require_relative 'save'

class Title
  include SaveLoad

  def initialize
    puts
    puts <<-TITLE

    [0;1;35;95m░█[0;1;31;91m▀▀[0;1;33;93m░█[0;1;32;92m░█[0;1;36;96m░█[0;1;34;94m▀▀[0;1;35;95m░█[0;1;31;91m▀▀[0;1;33;93m░█[0;1;32;92m▀▀[0m
    [0;1;31;91m░█[0;1;33;93m░░[0;1;32;92m░█[0;1;36;96m▀█[0;1;34;94m░█[0;1;35;95m▀▀[0;1;31;91m░▀[0;1;33;93m▀█[0;1;32;92m░▀[0;1;36;96m▀█[0m
    [0;1;33;93m░▀[0;1;32;92m▀▀[0;1;36;96m░▀[0;1;34;94m░▀[0;1;35;95m░▀[0;1;31;91m▀▀[0;1;33;93m░▀[0;1;32;92m▀▀[0;1;36;96m░▀[0;1;34;94m▀▀[0m

      by José Sérgio

    TITLE
    puts '  Press ENTER to continue!'
    input = ''
    until input == "\n"
      input = gets
      case input
      when "\n"
        puts
        system 'clear'
        second_menu
      end
    end
  end

  def second_menu
    puts
    puts <<-TITLE

        [0;1;35;95m░█[0;1;31;91m▀▀[0;1;33;93m░█[0;1;32;92m░█[0;1;36;96m░█[0;1;34;94m▀▀[0;1;35;95m░█[0;1;31;91m▀▀[0;1;33;93m░█[0;1;32;92m▀▀[0m
        [0;1;31;91m░█[0;1;33;93m░░[0;1;32;92m░█[0;1;36;96m▀█[0;1;34;94m░█[0;1;35;95m▀▀[0;1;31;91m░▀[0;1;33;93m▀█[0;1;32;92m░▀[0;1;36;96m▀█[0m
        [0;1;33;93m░▀[0;1;32;92m▀▀[0;1;36;96m░▀[0;1;34;94m░▀[0;1;35;95m░▀[0;1;31;91m▀▀[0;1;33;93m░▀[0;1;32;92m▀▀[0;1;36;96m░▀[0;1;34;94m▀▀[0m

          by José Sérgio

    TITLE
    puts ''
    puts '1 - New Game'
    puts '2 - Load Game'
    input = ''
    until %w[1 2].include?(input)
      input = gets.chomp
      case input
      when '1'
        system 'clear'
        game = Game.new
        game.play
      when '2'
        load_game
      else
        puts 'Please Enter one of the options'
      end
    end
  end
end
