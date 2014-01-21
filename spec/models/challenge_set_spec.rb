# == Schema Information
#
# Table name: challenge_sets
#
#  id            :integer          not null, primary key
#  challenges_id :integer
#  name          :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

require 'spec_helper'

describe ChallengeSet do
  describe "Associations" do
     it { should have_many(:challenges) }
  end
end
