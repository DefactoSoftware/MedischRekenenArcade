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
#

require 'spec_helper'

describe Answer do
  describe "Associations" do
    it { should belong_to(:user) }
    it { should belong_to(:problem) }
    it { should belong_to(:user_challenge) }
  end
end
