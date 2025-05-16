class RandomWord
  def random_word
    wordlist = File.readlines('wordlist.txt', chomp: true)

    filtered_wordlist = wordlist.filter { |w| w.length.between?(5, 12) }

    num = rand(1..(filtered_wordlist.length - 1))

    filtered_wordlist[num]
  end
end
