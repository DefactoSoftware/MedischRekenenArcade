class PercentageProblemGeneratorOne < ProblemGenerator
  def problem
    unit = "ml";
    variable1 = Float(rand(1...10)*10).round(2)
    variable2 = Float(1 + rand(1...4)).round(2)
    theory = "#{variable1}% van #{variable2}#{unit}"
    question = "Geef het resultaat";
    problem = Problem.create(question: question, theory:theory, unit: Unit.where(sign:unit).first)

    step1 = problem.add_step(Skill.where(name: AVAILABLE_SKILLS[2]).first_or_create, (variable1/100), variable2)
    puts step1.formula
    problem.update_attributes(formula: "#{step1.formula}")
    problem
  end
end
