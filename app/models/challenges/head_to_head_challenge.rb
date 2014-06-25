# == Schema Information
#
# Table name: head_to_head_challenges
#
#  id            :integer          not null, primary key
#  challenger_id :integer
#  challenged_id :integer
#  challenge_id  :integer
#  points_bet    :integer
#  status        :integer          default(0)
#  created_at    :datetime
#  updated_at    :datetime

class HeadToHeadChallenge < ActiveRecord::Base
  enum status: [:open, :accepted, :finished]
  belongs_to :challenger, class_name: 'User'
  belongs_to :challenged, class_name: 'User'
  belongs_to :challenge
  has_many :user_challenges

  after_create :notify_users

  def user_finished(user)
    if challenger == user
      challenger_amount_answered >= challenge.number_of_problems
    else
      challenged_user_challenge.amount_answered >= challenge.number_of_problems
    end
  end

  def user_is_challenger(user)
    user == challenger
  end

  def check_finish
    challenger_amount_answered == challenge.number_of_problems && challenged_user_challenge.amount_answered == challenge.number_of_problems
  end

  def winner
    if !finished?
      User.none
    else
      if challenger_score > challenged_score
        challenger
      elsif challenged_score > challenger_score
        challenged
      else
        if challenger_time > challenged_time
          challenged
        elsif challenger_time < challenged_time
          challenger
        else
          nil
        end
      end
    end
  end

  def other_player(user)
    return challenger if challenged == user
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

  def challenger_amount_answered
    challenger_user_challenge.amount_answered
  end

  def challenged_amount_answered
    challenged_user_challenge.amount_answered
  end

  def challenger_score
    challenger_user_challenge.amount_good - challenger_user_challenge.amount_fail
  end

  def challenged_score
    challenged_user_challenge.amount_good - challenged_user_challenge.amount_fail
  end

  def challenger_time
    challenger_user_challenge.updated_at - challenger_user_challenge.created_at
  end

  def challenged_time
    challenged_user_challenge.updated_at - challenged_user_challenge.created_at
  end

  private
  def challenger_user_challenge
    user_challenges.where(user: challenger).last || UserChallenge.new
  end

  def challenged_user_challenge
    user_challenges.where(user: challenged).last || UserChallenge.new
  end
end
