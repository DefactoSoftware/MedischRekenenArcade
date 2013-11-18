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

require 'spec_helper'

describe Step do
  describe "Associations" do
    it { should have_many(:step_variables) }
  end

  let(:var1) { FactoryGirl.create(:variable) }
  let(:var2) { FactoryGirl.create(:variable) }

  describe "Class methods" do
    it "Should create a step with adding formula" do
      step = Step.generate_step(Problem.create, Skill.create(name: "adding"), var1, var2)
      expect(step.formula).to eq("(#{var1.value} + #{var2.value})")
      expect(step.get_result).to eq(var1.value + var2.value)
    end

    it "Should create a step with subtracting formula" do
      step = Step.generate_step(Problem.create, Skill.create(name: "subtracting"), var1, var2)
      expect(step.formula).to eq("(#{var1.value} - #{var2.value})")
      expect(step.get_result).to eq(var1.value - var2.value)
    end

    it "Should create a step with multiplying formula" do
      step = Step.generate_step(Problem.create, Skill.create(name: "multiplying"), var1, var2)
      expect(step.formula).to eq("(#{var1.value} * #{var2.value})")
      expect(step.get_result).to eq(var1.value * var2.value)
    end

    it "Should create a step with dividing formula" do
      step = Step.generate_step(Problem.create, Skill.create(name: "dividing"), var1, var2)
      expect(step.formula).to eq("(#{var1.value} / #{var2.value})")
      expect(step.get_result).to eq(var1.value / var2.value)
    end
  end
end
