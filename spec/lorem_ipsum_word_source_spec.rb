require 'lorem_ipsum_word_source'

describe LoremIpsumWordSource do
  describe "#initialize" do
    it "should return an instance of LoremIpsumWordSorce" do
      LoremIpsumWordSource.new.should be_an_instance_of(LoremIpsumWordSource)
    end
    it "should load lorem_ipsum.txt" do
      pending
    end
    it "should be set to the beginning of the loaded string" do
      pending
    end
  end

  describe "#next_word" do
    it "should return the next work" do
      pending
    end
    it "shift through the loaded string" do
      pending
    end
  end

  describe "#top_5_words" do
    context "words seen have include more than 5 unique words" do
      it "should return an ordered list of 5 most seen words ordered asc of usage" do
        pending
      end
    end
    context "words seen have include more than 5 unique words" do
      it "should include nil as placeholders for words not available" do
        pending
      end
    end
  end

  describe "#top_5_consonants" do
    context "words seen have has more than 5 consonants" do
      it "should return an array of 5 most used consonants in the string ordered asc of usage" do
        pending
      end
    end
    context "words seen have less than 5 consonants" do
      it "should return an array with nil as placeholders for consonants not available" do
        pending
      end
    end
  end

  describe "#count" do
    it "should return a count of total words seen" do
      pending
    end
  end

  describe "#run" do
    context "all loaded words were seen" do
      it "should return false" do
        pending
      end
    end
    context "not all loaded words were seen" do
      it "should return true" do
        pending
      end
    end
  end
end