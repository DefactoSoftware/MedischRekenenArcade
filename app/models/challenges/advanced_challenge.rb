require 'problem_factory'

class AdvancedChallenge < Challenge
  def create_problem
    ProblemFactory.new(self).problem
  end
end
