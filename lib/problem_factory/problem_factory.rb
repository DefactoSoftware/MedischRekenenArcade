class ProblemFactory
  def initialize(name, user)
    @name = name
    @user = user
  end

  def problem
    if Problem::VALID_PROBLEMS.include? @name
      @name.constantize.new.generate(@user)
    else
      Problem.generate_random(1)
    end
  end
end
