require 'lorem_ipsum_word_source'

describe LoremIpsumWordSource do
  subject { LoremIpsumWordSource.new }

  it { should be_an_instance_of(LoremIpsumWordSource) }
  it { should be_a_kind_of(WordSource) }

  describe "#initialize" do
    it "should load lorem_ipsum.txt" do
      file = double('file')
      File.should_receive(:open).with("lorem_ipsum.txt").and_return(file)
      file.should_receive(:read).and_return("lorem ipsum")
      subject.loaded_words.should == ['lorem', 'ipsum']
    end
  end
end