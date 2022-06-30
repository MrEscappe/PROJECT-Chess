# frozen_string_literal: true

require 'yaml'

module SaveLoad
  def save_game(instance)
    dump = YAML.dump(instance)
    Dir.mkdir 'saved_games' unless Dir.exist? 'saved_games'

    filename = generate_filename
    File.write(File.open("saved_games/#{filename}", 'w+'), dump)
    puts "Game was saved as #{filename}"
  end
  
  def generate_filename
    date = Time.now.strftime('%Y-%m-%d').to_s
    time = Time.now.strftime('%H:%M:%S').to_s
    "Chess #{date} at #{time}"
  end

  def load_game
    puts
    file_name = files_saved
    # File.open("saved_games/#{file_name}") do |file|
    #   YAML.safe_load(file)
    # end
    old_game = YAML.load(File.read("saved_games/#{file_name}"))
    old_game.play
  end

  def files_saved
    saved_files = game_list
    if saved_files == []
      puts 'There are no saved games!'
      exit
    else
      print_games(saved_files)
      file_number = select_saved_games(saved_files.size)
      saved_files[file_number.to_i - 1]
    end
  end

  def print_games(files)
    puts 'Files name(s)'
    files.each_with_index do |name, idx|
      puts "#{idx + 1} - #{name}"
    end
  end

  def select_saved_games(number)
    file_number = gets.chomp
    return file_number if file_number.to_i.between?(1, number)

    puts 'Input error! Enter a valid file number'
    select_saved_games(number)
  end

  def game_list
    list = []
    return game_list unless Dir.exist? 'saved_games'

    Dir.entries('saved_games').each do |saves|
      list << saves if saves.match(/(Chess)/)
    end
    list
  end
end
