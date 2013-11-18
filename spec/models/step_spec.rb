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

require 'spec_helper'

describe Step do
  let(:var1) { Float(rand(1...20)) }
  let(:var2) { Float(rand(1...20)) }

  describe "Class methods" do
    it "Should create a step with adding formula" do
      step = Step.generate_step(Problem.create, Skill.create(name: "adding"), var1, var2)
      expect(Step.last.formula).to eq("(#{var1} + #{var2})")
      expect(Step.last.get_result).to eq(var1 + var2)
    end

    it "Should create a step with subtracting formula" do
      step = Step.generate_step(Problem.create, Skill.create(name: "subtracting"), var1, var2)
      expect(Step.last.formula).to eq("(#{var1} - #{var2})")
      expect(Step.last.get_result).to eq(var1 - var2)
    end

    it "Should create a step with multiplying formula" do
      step = Step.generate_step(Problem.create, Skill.create(name: "multiplying"), var1, var2)
      expect(Step.last.formula).to eq("(#{var1} * #{var2})")
      expect(Step.last.get_result).to eq(var1 * var2)
    end

    it "Should create a step with dividing formula" do
      step = Step.generate_step(Problem.create, Skill.create(name: "dividing"), var1, var2)
      expect(Step.last.formula).to eq("(#{var1} / #{var2})")
      expect(Step.last.get_result).to eq(var1 / var2)
    end
  end
end
