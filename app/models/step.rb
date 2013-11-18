# == Schema Information
#
# Table name: steps
#
#  id         :integer          not null, primary key
#  formula    :string(255)
#  skill_id   :integer
#  problem_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class Step < ActiveRecord::Base
  has_many :step_variables
  belongs_to :skill
  belongs_to :problem


  def self.generate_step(problem, skill, variable1, variable2)
    step = Step.create(problem: problem, formula: create_formula(skill.name, variable1.value, variable2.value), skill: skill)
    create_step_variables(step, variable1, variable2)
    step
  end

  def self.create_step_variables(step, variable1, variable2)
    StepVariable.create(step: step, variable: variable1)
    StepVariable.create(step: step, variable: variable2)
  end

  def self.create_formula(skill_name, value1, value2)
    case skill_name
      when "adding"
        formula = "(#{value1} + #{value2})"
      when "subtracting"
        formula = "(#{value1} - #{value2})"
      when "multiplying"
        formula = "(#{value1} * #{value2})"
      when "dividing"
        formula = "(#{value1} / #{value2})"
    end
  end

  def get_result
    eval(formula)
  end
end
