class Isomorphic
  attr_accessor :word1, :word2

  def initialize word1, word2
    @word1 = word1
    @word2 = word2
  end

  def isomorphic?
    return false unless similar_size?

    mapped_letters = {}

    word1.split('').each_with_index do |letter, index|
      letter2 = word2.split('')[index]
      if mapped_letters.has_key?(letter)
        return false unless mapped_letters[letter] == letter2
      else
        mapped_letters[letter] = letter2
      end
    end

    return true
  end

  def similar_size?
    word1.size == word2.size
  end
end
