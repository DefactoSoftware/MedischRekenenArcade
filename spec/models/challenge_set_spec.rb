# == Schema Information
#
# Table name: challenge_sets
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  locked     :boolean
#  created_at :datetime
#  updated_at :datetime
#  badge      :integer
#

require 'spec_helper'

describe ChallengeSet do
  describe "Associations" do
     it { should have_many(:challenges) }
  end
end
