class PercentageUnitToHundred < Problem
  def self.generate
    unit = AVAILABLE_UNITS[rand(0...AVAILABLE_UNITS.length)]
    unit_question = "%";

    variable1 = Float(rand(1...100)).round(2)
    variable2 = Float(rand(1...100)).round(2)

    theory = "#{variable1}#{unit_question} is #{variable2}#{unit}, hoeveel is 100#{unit_question} "

    problem = self.create(theory:theory, unit: Unit.where(sign:unit).first)

    step1 = problem.add_step(Skill.where(name: AVAILABLE_SKILLS[1]).first_or_create, variable2, variable1)

    problem.update_attributes(formula: "#{step1.formula} * 100")
    problem
  end
end
