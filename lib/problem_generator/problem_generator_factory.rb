class ProblemGeneratorFactory
  def initialize(challenge)
    @challenge = challenge
  end

  def build
    ProblemGenerator.new(@challenge)
  end
end
