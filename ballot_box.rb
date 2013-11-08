class BallotBox
  attr_reader :ballots

  def initialize(ballots)
    @ballots = ballots || []
  end

  def sorted_tally
    @results ||= Hash[tally.sort_by{|c,v| c == :exhausted ? 0 : v}.reverse]
  end

  def lowest_candidate
    @lowest_candidate ||= begin
      candidate = sorted_tally.to_a.reverse.find{|c,v| c != :exhausted}
      candidate.first if candidate
    end
  end

  def next_round
    BallotBox.new(remove_lowest_candidate_from_ballots)
  end

  def number_of_votes
    ballots.length
  end

  def grouped_ballots
    @grouped_ballots ||= ballots.group_by(&:first_choice)
  end
  private :grouped_ballots

  def tally
    grouped_ballots.inject({}) do |results, (candidate, ballots)|
      results[candidate] = ballots.length
      results
    end
  end
  private :tally

  def remove_lowest_candidate_from_ballots
    ballots.map{|b| b.remove(lowest_candidate)}
  end
  private :remove_lowest_candidate_from_ballots
end