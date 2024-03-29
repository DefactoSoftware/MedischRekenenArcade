# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  username               :string(255)      not null
#  name                   :string(255)
#  profilepicture_url     :string(255)      default("/assets/no_profile.jpg")
#  created_at             :datetime
#  updated_at             :datetime
#  user_group_id          :integer
#  sash_id                :integer
#  level                  :integer          default(0)
#

class User < ActiveRecord::Base
  has_merit

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_skills
  belongs_to :user_group

  has_many :answers
  has_many :activities
  has_many :notifications

  has_many :friendships
  has_many :friends, through: :friendships
  has_many :inverse_friendships,
           class_name: "Friendship",
           foreign_key: "friend_id"
  has_many :inverse_friends,
           through: :inverse_friendships,
           source: :user

  validates :username, presence: true, uniqueness: true

  after_create :init_redis
  after_create :init_user_skills

  has_many :user_challenges
  has_many :challenges, -> { uniq }, through: :user_challenges

  def recent_activities(limit = 6)
    activities.order("created_at DESC").limit(limit)
  end

  def increase_points(value)
    add_points(value)
    update_leaderboard(value)
  end

  def decrease_points(value)
    subtract_points(value)
    update_leaderboard(value * -1)
  end

  def challenges_completed_successfully
    amount = 0
    user_challenges.each do |user_challenge|
      amount += 1 if user_challenge.success?
    end
    amount
  end

  def head_to_head_challenges
    user_challenges.where("head_to_head_challenge_id IS NOT NULL")
  end

  def normal_challenges
    user_challenges.where("head_to_head_challenge_id IS NULL")
  end

  def guest?
    false
  end

  def friends_with?(user)
    !Friendship.where(user: self, friend: user).empty?
  end

  private

  def init_redis
    RedisLeaderboard.get.rank_member(id, 0)
  end

  def init_user_skills
    Skill.all.each do |skill|
      UserSkill.create(skill: skill, user: self)
    end
  end

  def update_leaderboard(value)
    highscore_lb = RedisLeaderboard.get
    if highscore_lb.score_for(id)
      new_score = highscore_lb.score_for(id) + value
    else
      value
    end
    highscore_lb.rank_member(id, new_score)
  end
end
