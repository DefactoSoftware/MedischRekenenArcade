# == Schema Information
#
# Table name: problems
#
#  id         :integer          not null, primary key
#  formula    :string(255)
#  question   :string(255)
#  theory     :text
#  difficulty :float
#  created_at :datetime
#  updated_at :datetime
#  unit_id    :integer
#

class Problem < ActiveRecord::Base
  has_many :steps
  has_many :skills, through: :steps
  belongs_to :unit

  AVAILABLE_SKILLS = ["Addition", "Division", "Multiplication", "Subtraction"]
  AVAILABLE_UNITS = ["mg", "g", "kg", "ml", "cl", "dl", "l"]

  def add_step(skill, variable1, variable2)
    Step.generate_step(self, skill, variable1, variable2)
  end

  def get_result
    eval(formula)
  end

  def self.generate_random(steps)
    problem = self.create
    steps.times do
      problem.add_step(
        Skill.get_random,
        (problem.steps.last ? problem.steps.last.get_result : Float(rand(1...100))),
        Float(rand(1...100))
      )
    end
    problem.generate_theory_and_formula!
  end

  def self.generate_random_with_skills(steps, skills)
    problem = self.create
    steps.times do
      problem.add_step(
        skills[rand(0..skills.count-1)],
        Float(rand(1..100)),
        Float(rand(1..100))
      )
    end
    problem.generate_theory_and_formula!
  end

  def generate_theory_and_formula!
    theory = "Give the result of the following: "
    formula = ""
    steps.each do |step|
      if formula.empty?
        formula = Formula.new(step.formula)
        formula = "#{step.formula}"
        theory = theory + "#{step.formula}"
      else
        formula = "#{formula} + #{step.formula}"
        theory = "#{theory} + #{step.formula}"
      end
    end
    self.update_attributes(theory: theory, formula:formula, unit: Unit.where(name: "Drops").first)
    self
  end
end
