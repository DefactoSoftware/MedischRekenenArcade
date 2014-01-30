class ProblemFactory
  def initialize(name)
    @name = name
  end

  def problem
    if Problem::VALID_PROBLEMS.include? @name
      @name.constantize.generate
    else
      Problem.generate_random(1)
    end
  end
end
