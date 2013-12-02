require './lib/word_source.rb'

class LoremIpsumWordSource < WordSource
  attr_accessor :loaded_words, :seen_words, :seen_consonants

  def initialize
    super
    file = File.open("lorem_ipsum.txt")
    @loaded_words += file.read.scan(/\w+/)
  end

end
