class LoremIpsumWordSource
  attr_accessor :loaded_words, :seen_words

  def initialize
    file = File.open("lorem_ipsum.txt")
    #self.src = file.read
    @loaded_words = []
    @loaded_words += file.read.scan(/\w+/)
    @seen_words = []
  end
  def next_word
    @seen_words << @loaded_words.shift
    @seen_words.last
  end
  def count
    @seen_words.length
  end
  def run
    !@loaded_words.empty?
  end
end
