class SecretWord
  attr_accessor :random_word

  def initialize
    @random_word
  end

  # select random word from google file between the length's of 5 and 12
  def select_word
    word_list = File.open('google-10000-english-no-swears.txt', 'r').readlines.map(&:chomp).select do |word|
      word.length.between?(5, 12)
    end
    @random_word = word_list.sample
  end
end
