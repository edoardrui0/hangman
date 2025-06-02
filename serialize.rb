module Serialize
  # Checks for saved_game file then displays all saved games to user
  def load_game
    return unless File.exist?('saved_games')

    puts "Here's a list of the saved games:"
    Dir.children('saved_games').each { |file| puts "- #{file}" }
    puts 'Please input a filename you wish to load i.e "filename.json"'
    filename = gets.chomp
    from_json(filename)
  end

  # Loads selected save file and parses it from JSON
  def from_json(filename)
    f = JSON.parse(File.read("saved_games/#{filename}"), symbolize_names: true) # might need to symbolize_names: true
    @word.random_word = f[:word]
    @display = f[:display]
    @life = f[:life]
    @player.misses = f[:player_misses]
    @player.guess_history = f[:player_guess_history]
  end

  # Converts current game into JSON
  def to_json(filename)
    Dir.mkdir('saved_games') unless File.exist?('saved_games')
    File.open("saved_games/#{filename}", 'w') do |f|
      JSON.dump({
                  word: @word.random_word,
                  display: @display,
                  life: @life,
                  player_misses: @player.misses,
                  player_guess_history: @player.guess_history
                }, f)
    end
  end
end
