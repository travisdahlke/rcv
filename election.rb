require 'csv'

class Election
  attr_reader :input, :output, :ballot_box

  def initialize(input = $stdin, output = $stdout)
    @input = input
    @output = output
    init_ballot_box
  end

  def init_ballot_box
    csv = CSV(input)
    ballots = csv.map{|row| Ballot.new(row)}
    @ballot_box = BallotBox.new(ballots)
  end
  private :init_ballot_box

  def tabulate
    round = 1
    current_box = ballot_box
    begin
      tally = current_box.sorted_tally
      print_round(tally, round)
      round += 1
      current_box = current_box.next_round
    end until winner?(tally)
    print_winner(tally)
  end

  def print_round(tally, round)
    output.puts "Round #{round}"
    tally.each do |candidate, total|
      output.puts "#{candidate}: #{total} (#{(total.to_f/total_votes.to_f * 100).round(2)}%)"
    end
  end

  def print_winner(tally)
    output.puts "Congratulations #{tally.keys.first}!"
  end

  def total_votes
    @total_votes ||= ballot_box.number_of_votes
  end

  def winner?(tally)
    tally.values.first > total_votes / 2 + 1 || tally.length < 3
  end
end