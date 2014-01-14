class ProblemFactory
  def initialize(challenge)
    @challenge = challenge
  end

  def problem
    eval(@challenge.name).generate
  end
end
