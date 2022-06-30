# frozen_string_literal: true

# title #=> prints the title of the game and waits 3 seconds

class Title
  puts
  puts <<-TITLE

    [0;1;35;95m░█[0;1;31;91m▀▀[0;1;33;93m░█[0;1;32;92m░█[0;1;36;96m░█[0;1;34;94m▀▀[0;1;35;95m░█[0;1;31;91m▀▀[0;1;33;93m░█[0;1;32;92m▀▀[0m
    [0;1;31;91m░█[0;1;33;93m░░[0;1;32;92m░█[0;1;36;96m▀█[0;1;34;94m░█[0;1;35;95m▀▀[0;1;31;91m░▀[0;1;33;93m▀█[0;1;32;92m░▀[0;1;36;96m▀█[0m
    [0;1;33;93m░▀[0;1;32;92m▀▀[0;1;36;96m░▀[0;1;34;94m░▀[0;1;35;95m░▀[0;1;31;91m▀▀[0;1;33;93m░▀[0;1;32;92m▀▀[0;1;36;96m░▀[0;1;34;94m▀▀[0m

      by José Sérgio

  TITLE
  puts '  Press ENTER to continue!'
  input = gets
  if input == '\n'
    puts ' '
    puts ' '
    system 'clear'
  end
  # print 'Loading'
  # 3.times do
  #   print('.')
  #   sleep(1)
  # end
  
end
