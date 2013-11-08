class Ballot
  attr_reader :choices

  def initialize(choices)
    @choices = choices.compact || []
  end

  def first_choice
    choices.first || :exhausted
  end

  def remove(*candidates)
    Ballot.new(choices.reject{|choice| candidates.include?(choice)})
  end
end