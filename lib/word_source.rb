class WordSource
  attr_accessor :loaded_words, :seen_words, :seen_consonants

  def initialize
    @loaded_words =[]
    @seen_words = {}
    @seen_consonants = {}
  end

  def next_word
    unless loaded_words.empty?
      word = loaded_words.shift.downcase

      seen_words[word].nil? ? seen_words[word]=1 : seen_words[word]+=1
      word.gsub(/[aeiou]/, '').each_char do | consonant |
        seen_consonants[consonant].nil? ? seen_consonants[consonant]=1 : seen_consonants[consonant]+=1
      end
      word
    end
  end

  def count
    c = 0
    seen_words.each_value { |v| c += v }
    c
  end

  def run
    until loaded_words.empty?
      next_word
    end
    true
  end

  def top_5_words
    sorter(seen_words)
  end

  def top_5_consonants
    sorter(seen_consonants)
  end

  private

  def sorter(hash)
    sorted_items = []
    sorted_items_array = hash.sort_by{|item, count| [-count,item]}
    i = 0
    5.times do
      sorted_items << (sorted_items_array[i].nil? ? nil : sorted_items_array[i][0])
      i+=1
    end
    sorted_items
  end
end