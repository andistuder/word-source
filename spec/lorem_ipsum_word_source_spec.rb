require 'lorem_ipsum_word_source'

describe LoremIpsumWordSource do
  subject { LoremIpsumWordSource.new }
  let(:process_all_words) do
    subject.loaded_words.length.times do
      subject.next_word
    end
  end

  describe "#initialize" do
    it "should return an instance of LoremIpsumWordSorce" do
      subject.should be_an_instance_of(LoremIpsumWordSource)
    end
    it "should load lorem_ipsum.txt" do
      file = double('file')
      File.should_receive(:open).with("lorem_ipsum.txt").and_return(file)
      file.should_receive(:read).and_return("lorem ipsum")
      subject.loaded_words.should == ['lorem', 'ipsum']
    end
    it "should be set to the beginning of the loaded string" do
      subject.seen_words.should be_empty
    end
  end

  describe "#next_word" do
    it "should return the next word, capitalisation normalised" do
      subject.next_word.should == 'lorem'
    end
    it "shift through the loaded string" do
      expected_squence = %w(lorem ipsum dolor sit amet consectetur)
      expected_squence.each do |word|
        subject.next_word.should == word
      end
    end
  end

  describe "#top_5_words" do
    context "words seen include 5 or more unique words" do
      it "should return an ordered list of 5 most seen words ordered desc of usage and alphabetical if same usage" do
        File.stub_chain(:open, :read).and_return("lorem,ipsum,lorem,sit,sit,sit,consectetur,elit,zappa")
        process_all_words
        subject.top_5_words.should == ["sit", "lorem", "consectetur", "elit", "ipsum"]
      end
      it "should normalise capitalisation" do
        File.stub_chain(:open, :read).and_return("Lorem,ipsum,lorem,sit,Sit,sit,consectetur,elit")
        process_all_words
        subject.top_5_words.should == ["sit", "lorem", "consectetur", "elit", "ipsum"]
      end
    end
    context "words seen include less than 5 unique words" do
      it "should include nil as placeholders for words not available" do
        File.stub_chain(:open, :read).and_return("Lorem,ipsum")
        process_all_words
        subject.top_5_words.should == ["ipsum", "lorem", nil, nil, nil]
      end
    end
  end

  describe "#top_5_consonants" do
    context "words seen have has more than 5 consonants" do
      it "should return ordered liast of 5 most used consonants ordered desc of usage and alphabetical if same usage" do
        File.stub_chain(:open, :read).and_return("lorem,ipsum,lorem,sit,sit,sit")
        process_all_words
        subject.top_5_consonants.should == ["s", "m", "t", "l", "r"]
      end
      it "should normalise capitalisation" do
        File.stub_chain(:open, :read).and_return("lorem,ipsum,lorem,sit,Sit,sit")
        process_all_words
        subject.top_5_consonants.should == ["s", "m", "t", "l", "r"]
      end
    end
    context "words seen include less than 5 unique consonants" do
      it "should return an array with nil as placeholders for consonants not available" do
        File.stub_chain(:open, :read).and_return("ipsum,sit,Sit,sit")
        process_all_words
        subject.top_5_consonants.should == ["s", "t", "m", "p", nil]
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