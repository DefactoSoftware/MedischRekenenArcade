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

require 'spec_helper'

describe Problem do
  describe "Associations" do
    it { should have_many(:steps) }
    it { should belong_to(:unit) }
  end



  describe "Methods" do
    before :each do
      Skill.create(name:"adding")
      Skill.create(name:"dividing")
      Skill.create(name:"multiplying")
      Skill.create(name:"subtracting")
    end

    it "should create a Problem with amount of steps equal to difficulty" do
      difficulty = rand(1...10)
      problem = Problem.generate_random(difficulty)
      expect(problem.steps.count).to eq(difficulty)
    end

  end
end
