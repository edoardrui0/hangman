class Letters
  attr_accessor :letters_arr

  def initialize
    @letters_arr = []
  end

  def obtain_letter
    obtain_letter = gets.chomp
    @letters_arr.push(obtain_letter)
    @letters_arr
  end
end
