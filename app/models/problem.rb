# == Schema Information
#
# Table name: problems
#
#  id         :integer          not null, primary key
#  formula    :string(255)
#  question   :string(255)
#  theory     :string(255)
#  difficulty :float
#  created_at :datetime
#  updated_at :datetime
#  unit_id    :integer
#

class Problem < ActiveRecord::Base
  has_many :steps
  has_many :skills, through: :steps
  belongs_to :unit

  AVAILABLE_SKILLS = ["adding", "dividing", "multiplying", "subtracting"]

  def add_step(skill, variable1, variable2)
    Step.generate_step(self, skill, variable1, variable2)
  end

  def self.maxisporin
    unit = "ml";
    variable1 = Float(0.25 + rand(1...9) * 0.25).round(2)
    variable2 = Float(1 + rand(1...4)).round(2)
    variable3 = Float(0.1 + rand(1...22) * 0.1).round(2)
    variable4 = Float(0.1 + rand(1...9) * 0.2).round(2)
    theory = "Geef een patient parentaal #{variable1} Maxisporin per dag, verdeeld over #{variable2} injecties." +
             "In voorraad is Maxisporin #{variable3}. Dit poeder dient opgelost te worden in 4ml aqua bidestillata" +
             "ter verkrijging van #{variable4} injectievloeistof."
    question = "Hoeveel #{unit} injecteer je per keer?";
    problem = Problem.create(question: question, theory:theory, unit: Unit.where(sign:unit).first)

    step1 = problem.add_step(Skill.where(name: AVAILABLE_SKILLS[1]).first_or_create, variable1, variable2)
    step2 = problem.add_step(Skill.where(name: AVAILABLE_SKILLS[1]).first_or_create, variable3, variable4)
    problem.update_attributes(formula: "#{step1.formula} / #{step2.formula}")
    problem
  end

  def get_result
    eval(formula)
  end

  def self.generate_random(steps)
    problem = self.create
    steps.times do
      problem.add_step(
        Skill.get_random,
        (problem.steps.last ? problem.steps.last.get_result : Float(rand(1...100)) ),
        Float(rand(1...100))
      )
      problem.update_attributes(formula: problem.get_formula)
    end
    problem
  end

  def self.generate_random_with_skills(difficulty, skills)
    problem = self.create
    difficulty.times do
      last_step = problem.steps.last
      problem.add_step(
        skills[rand(0..skills.count-1)],
        Float(rand(1..100)),
        Float(rand(1..100))
      )
    end
    theory = "Give the result of the following: "
    formula = ""
    problem.steps.each do |step|
      if formula.empty?
        formula = "#{step.formula}"
        theory = theory + "#{step.formula}"
      else
        formula = "#{formula}#{step.symbol}#{step.formula}"
        theory = "#{theory} #{step.symbol} #{step.formula}"
      end
    end
    problem.update_attributes(theory: theory, formula:formula, unit: Unit.where(name: "Drops").first)
    problem
  end
end
