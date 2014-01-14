class SolutionMaxisporin < Problem
  def self.generate
    unit = "ml";
    variable1 = Float(0.25 + rand(1...9) * 0.25).round(2)
    variable2 = Float(1 + rand(1...4)).round(2)
    variable3 = Float(0.1 + rand(1...22) * 0.1).round(2)
    variable4 = Float(0.1 + rand(1...9) * 0.2).round(2)
    theory = "Geef een patient parentaal #{variable1} Maxisporin per dag, verdeeld over #{variable2} injecties." +
             "In voorraad is Maxisporin #{variable3}. Dit poeder dient opgelost te worden in 4ml aqua bidestillata" +
             "ter verkrijging van #{variable4} injectievloeistof."
    question = "Hoeveel #{unit} injecteer je per keer?";
    problem = self.create(question: question, theory:theory, unit: Unit.where(sign:unit).first)

    step1 = problem.add_step(Skill.where(name: AVAILABLE_SKILLS[1]).first_or_create, variable1, variable2)
    step2 = problem.add_step(Skill.where(name: AVAILABLE_SKILLS[1]).first_or_create, variable3, variable4)
    problem.update_attributes(formula: "#{step1.formula} / #{step2.formula}")
    problem
  end
end
