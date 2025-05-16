require_relative 'rand'
require_relative 'letters'

class Hangman
  attr_accessor :game_word, :guesses

  def initialize
    @game_word = RandomWord.new.random_word
    @letters = Letters.new
    @guesses = 7
  end

  def gameplay
  end
end

new = Hangman.new
new.gameplay
