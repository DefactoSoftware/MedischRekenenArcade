class ProblemFactory
  def initialize(challenge)
    @challenge = challenge
  end

  def problem
    @challenge.name.constantize.generate
  end
end
