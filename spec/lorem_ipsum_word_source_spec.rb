require 'lorem_ipsum_word_source'

describe LoremIpsumWordSource do
  subject { LoremIpsumWordSource.new }

  describe "#initialize" do
    it "should return an instance of LoremIpsumWordSorce" do
      subject.should be_an_instance_of(LoremIpsumWordSource)
    end
    it "should load lorem_ipsum.txt" do
      #File.should_receive(:open).and_return(:file)
      subject.loaded_words.length.should == 4946
    end
    it "should be set to the beginning of the loaded string" do
      subject.seen_words.should be_empty
    end
  end

  describe "#next_word" do
    it "should return the next word" do
      subject.next_word.should == 'Lorem'
    end
    it "shift through the loaded string" do
      expected_squence = %w(Lorem ipsum dolor sit amet consectetur)
      expected_squence.each do |word|
        subject.next_word.should == word
      end
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
      n=3
      n.times do
        subject.next_word
      end
      subject.count.should == 3
    end
  end

  describe "#run" do
    context "all loaded words were seen" do
      it "should return false" do
        subject.loaded_words.length.times do
          subject.next_word
        end
        subject.run.should be_false
      end
    end
    context "not all loaded words were seen" do
      it "should return true" do
        subject.run.should be_true
      end
    end
  end
end