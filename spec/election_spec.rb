require_relative File.join('..','election')
require 'faker'
require 'csv'
require 'rubystats'

describe Election do
  before do
    @input = StringIO.new(%{"Bob","Mary","Tom"\n"Mary","Bob","Tom"\n"Bob","Tom","Mary"\n"Tom","Bob","Mary"})
    @output = StringIO.new
  end

  subject { Election.new(@input, @output) }

  describe "#tabulate" do
    before(:each) {subject.tabulate}
    it "should output the results of each round" do
      expect(@output.string).to match /Bob: 2/
    end

    it "should output the winner" do
      expect(@output.string).to match /Congratulations Bob!/
    end
  end

  describe "#random" do
    let(:candidates) {35.times.map{Faker::Name.name}}
    let(:ballots) {80_000.times.map{r = Rubystats::NormalDistribution.new(18, 3); 3.times.map{candidates[r.rng.round]}}}
    before do
      csv_string = CSV.generate do |csv|
        ballots.each do |ballot|
          csv << ballot
        end
      end
      @input = StringIO.new(csv_string)
      @output = $stdout
    end

    it "tabulates a random election" do
      subject.tabulate
    end
  end
end