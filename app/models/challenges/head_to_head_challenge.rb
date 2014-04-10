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

class HeadToHeadChallenge < ActiveRecord::Base
  enum status: [:open, :accepted, :finished]
  belongs_to :challenger, class_name: 'User'
  belongs_to :challenged, class_name: 'User'
  belongs_to :challenge
  has_many :user_challenges

  def points_for_challenger

  end

  def points_for_challenged

  end

  def winner

  end
end
