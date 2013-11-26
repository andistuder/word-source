class LoremIpsumWordSource
  attr_accessor :loaded_words, :seen_words

  def initialize
    file = File.open("lorem_ipsum.txt")
    #self.src = file.read
    @loaded_words = []
    @loaded_words += file.read.scan(/\w+/)
    @seen_words = {}
  end
  def next_word
    word = loaded_words.shift.downcase
    seen_words[word].nil? ? seen_words[word]=1 : seen_words[word]+=1
    word
  end
  def count
    c = 0
    seen_words.each_value { |v| c += v }
    c
  end
  def run
    !loaded_words.empty?
  end
  def top_5_words
    words = []
    sorted_words = seen_words.sort_by{|word, count| [-count,word]}
    i = 0
    5.times do
      words << (sorted_words[i].nil? ? nil : sorted_words[i][0])
      i+=1
    end
     words
  end
end
