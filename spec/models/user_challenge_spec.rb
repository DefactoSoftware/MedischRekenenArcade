# == Schema Information
#
# Table name: user_challenges
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  challenge_id :integer
#  success      :boolean
#  amount_fail  :integer          default(0)
#  amount_good  :integer          default(0)
#  created_at   :datetime
#  updated_at   :datetime
#

require 'spec_helper'

describe UserChallenge, :type => :model do
  describe "Associations" do
    it { is_expected.to belong_to(:challenge) }
    it { is_expected.to belong_to(:user) }
  end

  describe "Initialize" do
    it "should initialize with amount_good and amount_fail on 0" do
      userchallenge = UserChallenge.create()
      expect(userchallenge.amount_good).to eq(0)
      expect(userchallenge.amount_fail).to eq(0)
    end
  end
end
