class ProblemFactory
  def initialize(name, user)
    @name = name
    @user = user
  end

  def problem
    if Problem::VALID_PROBLEMS.include? @name
      @name.constantize.new.generate(@user)
    end
  end
end
