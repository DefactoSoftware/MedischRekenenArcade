# == Schema Information
#
# Table name: answers
#
#  id                :integer          not null, primary key
#  value             :float
#  user_id           :integer
#  problem_id        :integer
#  created_at        :datetime
#  updated_at        :datetime
#  user_challenge_id :integer
#  feedback          :string(255)
#

require 'spec_helper'

describe Answer do
  describe "Associations" do
    it { should belong_to(:user) }
    it { should belong_to(:problem) }
    it { should belong_to(:user_challenge) }
  end

  describe "#user" do
    context "with an actual user" do
      it "returns the user" do
        answer = FactoryGirl.create(:answer, user: FactoryGirl.create(:user))
        expect(answer.user).to be_a User
      end
    end

    context "without a user" do
      it "returns a Guest" do
        answer = FactoryGirl.create(:answer, user: nil)
        expect(answer.user).to be_a Guest
      end
    end
  end
end
