# == Schema Information
#
# Table name: challenges
#
#  id                 :integer          not null, primary key
#  number_of_problems :integer
#  name               :string(255)
#  timelimit          :integer
#  bonus              :integer
#  icon               :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  steps              :integer
#  type               :string(255)
#

require 'spec_helper'

describe Challenge do
  describe "Associations" do
    it { should have_many :skills }
    it { should have_many :challenge_skills }
  end



  describe "Valid challenge names" do
    let(:challenge_names) {
      %w(Addition_1 Addition_2 Addition_3
         Division_1 Division_2 Division_3
         Multiplication_1 Multiplication_2 Multiplication_3
         Subtraction_1 Subtraction_2 Subtraction_3
         Mixed_1 Mixed_2 Mixed_3
         PercentageAmountOfAmount PercentageOfUnit PercentageUnitToHundred)
    }

    it "creates the challenge" do
      challenge_names.each do |name|
        Challenge.create(name: name)
        expect(Challenge.last.name).to eq(name)
      end
    end

    it "doesn't create the challenge" do
      random_name = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
      expect{Challenge.create(name: random_name)}.to_not change{Challenge.count}.by(1)
    end
  end
end
