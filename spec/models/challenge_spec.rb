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
#  challenge_set_id   :integer
#

require 'spec_helper'

describe Challenge do
  describe "Associations" do
    it { should have_many :skills }
    it { should have_many :challenge_skills }
    it { should have_many :user_challenges }
    it { should belong_to :challenge_set }
  end



  describe "Valid challenge names" do
    Challenge::VALID_NAMES.each do |name|
      it { should allow_value(name).for(:name) }
    end

    it { should_not allow_value(Faker::HipsterIpsum.word).for(:name) }
    it { should_not allow_value("clearly a faulty challenge name").for(:name) }
  end
end
