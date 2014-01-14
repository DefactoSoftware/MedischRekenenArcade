class PercentageProblemGeneratorThree < ProblemGenerator
  def problem
    variable1 = Float(rand(1...50)).round(2)
    variable2 = Float(rand(6...10)*10).round(2)

    theory = "Hoeveel % is #{variable1}#{@unit} van #{variable2}#{@unit}"

    problem = Problem.create(theory:theory, unit: Unit.where(sign:@unit).first)

    step1 = problem.add_step(Skill.where(name: AVAILABLE_SKILLS[1]).first_or_create, variable1, variable2)
    problem.update_attributes(formula: "#{step1.formula}")
    problem
  end
end
