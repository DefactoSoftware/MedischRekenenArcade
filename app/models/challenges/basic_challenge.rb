class BasicChallenge < Challenge
  def create_problem
    Problem.generate_random_with_skills(self.steps, self.skills)
  end
end
