class Player
  attr_accessor :guess, :guess_history, :misses

  def initialize
    @guess = ''
    @guess_history = []
    @misses = []
  end

  # get input, then check whether to save game or validate guess
  def player_input
    input = gets.chomp
    if input == 'save'
      @guess = input
    else
      validate_input(input)
    end
  end

  # check if user's input is within range
  def validate_input(input = '')
    until input.length == 1 && input =~ /[a-z]/
      puts 'Please input a letter between a-z'
      input = gets.chomp.downcase
    end
    @guess = input
    check_history(input)
    @guess_history << @guess
  end

  # checks if input has previously been selected
  def check_history(input)
    if @guess_history.include?(input)
      puts 'You have already selected that letter'
      validate_input
    else
      false
    end
  end
end
