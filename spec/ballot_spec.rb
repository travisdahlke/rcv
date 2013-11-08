require_relative File.join('..','ballot')

describe Ballot do
  let(:choices) {[1,2,3]}
  subject { Ballot.new(choices) }

  it "has choices" do
    expect(subject.choices).to eq choices
  end

  let(:ballot) {Ballot.new([1,nil,3])}
  it "should remove nils" do
    expect(ballot.choices).to_not include(nil)
  end

  it "returns the first choice" do
    expect(subject.first_choice).to be 1
  end

  context "with no remaining choices" do
    let(:choices) {[]}

    it "returns exhausted for the first choice" do
      expect(subject.first_choice).to eq :exhausted
    end
  end

  describe "#remove" do
    let(:ballot) {subject.remove(1)}
    it "returns a new ballot with the candidate removed from choices" do
      expect(ballot).to_not be subject
      expect(ballot.first_choice).to be 2
    end

    let(:ballot) {subject.remove(1)}
    it "returns a new ballot with the candidates removed from choices" do
      ballot = subject.remove(1,2)
      expect(ballot).to_not be subject
      expect(ballot.first_choice).to be 3
    end
  end


end