class ProblemGeneratorFactory
  def initialize(challenge)
    @challenge = challenge
  end

  def build
    case @challenge.name
    when "Percentages 1"
      PercentageProblemGeneratorOne.new(@challenge)
    when "Percentages 2"
      PercentageProblemGeneratorTwo.new(@challenge)
    when "Percentages 3"
      PercentageProblemGeneratorThree.new(@challenge)
    else
      ProblemGenerator.new(@challenge)
    end
  end
end
