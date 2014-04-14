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

  after_create :notify_users

  def points_for_challenger

  end

  def points_for_challenged

  end

  def winner

  end

  def other_player(user)
    challenger if challenged == user
    challenged if challenger == user
  end

  def notify_users
    Notification.create(
      user: challenger,
      title: 'notifications.head_to_head_challenge.challenger.title',
      text: 'notifications.head_to_head_challenge.challenger.text',
      trackable: self,
      image: challenge.icon
    )
    Notification.create(
      user: challenged,
      title: 'notifications.head_to_head_challenge.challenged.title',
      text: 'notifications.head_to_head_challenge.challenged.text',
      trackable: self,
      image: challenge.icon
    )
  end
end
#HeadToHeadChallenge.create(challenger: User.first, challenged: User.first, challenge: Challenge.first)
