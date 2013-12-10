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
#

require 'spec_helper'

describe Challenge do
  describe "Associations" do
    it { should have_many :skills }
    it { should have_many :challenge_skills }
  end
end
