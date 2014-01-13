require 'problem_generator'
class AdvancedChallenge < Challenge
  def create_problem
    ProblemGeneratorFactory.new(self).build.problem
  end
end
