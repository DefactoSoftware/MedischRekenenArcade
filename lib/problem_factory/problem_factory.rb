class ProblemFactory
  def initialize(name)
    @name = name
  end

  def problem
    @name.constantize.generate
  end
end
