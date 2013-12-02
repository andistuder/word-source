require 'word_source'

describe WordSource do
  subject { WordSource.new }

  let(:process_all_words) do
    subject.loaded_words.length.times do
      subject.next_word
    end
  end

  describe "#initialize" do
    it "should return an instance of LoremIpsumWordSorce" do
      subject.should be_an_instance_of(WordSource)
    end
    it "should be set to the beginning of the loaded string" do
      subject.seen_words.should be_empty
    end
  end

  describe "#next_word" do
    it "should return the next word, capitalisation normalised" do
      subject.loaded_words = %w(Lorem ipsum)
      subject.next_word.should == 'lorem'
    end
    it "shift through the loaded string" do
      expected_squence = %w(lorem ipsum dolor sit amet consectetur)
      subject.loaded_words += expected_squence
      expected_squence.each do |word|
        subject.next_word.should == word
      end
    end
  end

  describe "#top_5_words" do
    context "words seen include 5 or more unique words" do
      it "should return an ordered list of 5 most seen words ordered desc of usage and alphabetical if same usage" do
        File.stub_chain(:open, :read).and_return("lorem,ipsum,lorem,sit,sit,sit,consectetur,elit,zappa")
        subject.loaded_words = %w(lorem ipsum lorem sit sit sit consectetur elit zappa")
        process_all_words
        subject.top_5_words.should == ["sit", "lorem", "consectetur", "elit", "ipsum"]
      end
      it "should normalise capitalisation" do
        subject.loaded_words = %w(lorem ipsum Lorem sit Sit sit consectetur elit zappa")
        process_all_words
        subject.top_5_words.should == ["sit", "lorem", "consectetur", "elit", "ipsum"]
      end
    end
    context "words seen include less than 5 unique words" do
      it "should include nil as placeholders for words not available" do
        subject.loaded_words = %w(lorem ipsum)
        process_all_words
        subject.top_5_words.should == ["ipsum", "lorem", nil, nil, nil]
      end
    end
  end

  describe "#top_5_consonants" do
    context "words seen have has more than 5 consonants" do
      it "should return ordered liast of 5 most used consonants ordered desc of usage and alphabetical if same usage" do
        subject.loaded_words = %w(lorem ipsum lorem sit sit sit)
        process_all_words
        subject.top_5_consonants.should == ["s", "m", "t", "l", "r"]
      end
      it "should normalise capitalisation" do
        subject.loaded_words = %w(lorem ipsum lorem sit sit sit)
        process_all_words
        subject.top_5_consonants.should == ["s", "m", "t", "l", "r"]
      end
    end
    context "words seen include less than 5 unique consonants" do
      it "should return an array with nil as placeholders for consonants not available" do
        subject.loaded_words = %w(ipsum sit Sit sit)
        process_all_words
        subject.top_5_consonants.should == ["s", "t", "m", "p", nil]
      end
    end
  end

  describe "#count" do
    it "should return a count of total words seen" do
      subject.loaded_words = %w(lorem ipsum lorem sit sit sit)
      n=3
      n.times do
        subject.next_word
      end
      subject.count.should == 3
    end
  end

  describe "#run" do
    before :each do
      subject.loaded_words = %w(lorem ipsum lorem sit sit sit)
    end
    it "should return true" do
      subject.run.should be_true
    end
    it "should process all loaded words" do
      subject.run
      subject.loaded_words.should be_empty
      subject.seen_words.should == {"lorem"=>2, "ipsum"=>1, "sit"=>3}
    end
  end
end