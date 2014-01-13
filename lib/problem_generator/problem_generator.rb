class ProblemGenerator
  AVAILABLE_SKILLS = ["adding", "dividing", "multiplying", "subtracting"]
  attr_reader :challenge

  def initialize(challenge)
    @challenge = challenge
  end
end
