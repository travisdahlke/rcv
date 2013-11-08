require_relative File.join('..','ballot_box')

describe BallotBox do
  def generate_ballots(*candidates)
    candidates.map do |candidate|
      ballot = double("ballot", first_choice: candidate)
      allow(ballot).to receive(:remove).with(anything)
      ballot
    end
  end

  let(:ballots) { generate_ballots("Bob", "Mary", "Joe", "Mary") }
  subject { BallotBox.new(ballots) }

  describe "#number_of_votes" do
    it "should be 4" do
      expect(subject.number_of_votes).to be 4
    end
  end

  it "tallies first choice votes" do
    expect(subject.sorted_tally["Mary"]).to be 2
    expect(subject.sorted_tally["Bob"]).to be 1
    expect(subject.sorted_tally.length).to be 3
    expect(subject.sorted_tally["Guy"]).to be_nil
  end

  it "should find the lowest ranked candidate" do
    expect(subject.lowest_candidate).to eq "Bob"
  end

  describe "#next_round" do
    let(:next_round) {subject.next_round}
    it "returns a new ballot box" do
      expect(next_round).to_not be subject
    end

    it "removes lowest candidate from all ballots" do
      ballots.each do |ballot|
        expect(ballot).to receive(:remove).with("Bob")
      end
      next_round
    end
  end
end