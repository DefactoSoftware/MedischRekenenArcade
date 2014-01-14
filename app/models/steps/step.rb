# == Schema Information
#
# Table name: steps
#
#  id         :integer          not null, primary key
#  skill_id   :integer
#  problem_id :integer
#  value1     :float
#  value2     :float
#  symbol     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Step < ActiveRecord::Base
  belongs_to :skill
  belongs_to :problem

  def self.generate_step(problem, skill, value1, value2)
    step = Step.create(problem: problem, skill: skill, value1: value1, value2: value2, type: skill.name)
  end

  def formula
    "(#{value1} #{symbol} #{value2})"
  end

  def get_result
    eval(formula)
  end
end
