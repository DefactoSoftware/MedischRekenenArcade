class PercentageProblemGeneratorTwo < ProblemGenerator
  def problem
    unit_question = "%";
    unit = "ml"
    variable1 = Float(rand(1...100)).round(2)
    variable2 = Float(rand(1...100)).round(2)
    theory = "#{variable1}#{unit_question} is #{variable2}#{unit}, hoeveel is 100#{unit_question} "
    question = "Geef het resultaat";
    problem = Problem.create(question: question, theory:theory, unit: Unit.where(sign:unit).first)

    step1 = problem.add_step(Skill.where(name: AVAILABLE_SKILLS[1]).first_or_create, variable2, variable1)
    problem.update_attributes(formula: "#{step1.formula} * 100")
    problem
  end
end
