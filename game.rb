require 'json'
require './serialize'
require './player'
require './secret_word'

class Game
  include Serialize
  attr_accessor :word, :player, :display, :life

  def initialize
    @word = SecretWord.new
    @player = Player.new
    @display = []
    @life = 8
    new_or_load
  end

  # if new game, create secret word and play game, else load game before playing
  def new_or_load
    puts 'Please select "1" to start a new game or "2" to load up a previous game'
    input = gets.to_i
    if input == 1
      word.select_word
      play_game
    elsif input == 2
      load_game # found in module Serialize
      # puts @display.join
      play_game
    else
      new_or_load
    end
  end

  # based on secret_word.word's length, create a display of the same length with underscores
  def make_display
    return false unless @display.empty?

    length = @word.random_word.length
    @display = Array.new(length, '_')
    @display.join(' ')
  end

  # check if player entered 'save', get filename
  def save_game
    return false unless player.guess == 'save'

    puts 'Enter a filename, no spaces'
    filename = gets.chomp
    to_json(filename)
    player.guess = ''
    puts 'Press "1" to continue or "2" to end the game'
    input = gets.chomp
    if input == '1'
      puts 'Enter any letter for a guess or "save" to save the game'
    elsif input == '2'
      @life = 0
    end
  end

  # check to see uf player_guess matches letter in secret_word.random_word
  def match
    return if player.guess == 'save'

    player.player_input

    if word.random_word.include?(player.guess)
      word_arr = word.random_word.chars
      word_arr.each_with_index do |letter, i|
        @display[i] = letter if letter == player.guess
      end
      puts "Your guess is correct: #{@display.join(' ')}"
    else
      miss
    end
  end

  # if wrong guess, add to misses, found in player.rb, and lose a life
  def miss
    return if player.guess == 'save'

    player.misses << player.guess
    puts 'That letter is not found in the secret word'
    puts "Here are all your misses so far: #{player.misses}"
    puts "You have #{life} lives left"
    @life -= 1
    puts @display.join(' ')
  end

  def check_winner
    if @display.join == word.random_word
      puts 'Congrats, you have won the game!'
      @life = 0
    elsif @life.zero?
      puts "This was the secret word: #{@word.random_word}"
      puts 'You have ran out of lives, sorry!'
    end
  end

  def replay
    puts "If you'd like to play again, enter '1'. If not, enter anything else"
    input = gets.chomp
    return unless input == '1'

    new_game
  end

  def new_game
    Game.new
  end

  def play_game
    puts 'Welcome to Ruby Hangman!'
    puts 'Enter any letter for a guess or "save" to save the game'
    until @life.zero?
      make_display
      match
      save_game
      check_winner
    end
    replay
  end
end

new = Game.new
