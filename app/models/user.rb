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
#  profilepicture_url     :string(255)      default("http://upload.wikimedia.org/wikipedia/commons/thumb/c/c3/John_Doe.jpg/220px-John_Doe.jpg")
#  created_at             :datetime
#  updated_at             :datetime
#  user_group_id          :integer
#

class User < ActiveRecord::Base
  has_merit

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  belongs_to :user_skill
  belongs_to :user_group
  has_many :points

  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user


  after_create :init_redis

  has_many :user_challenges
  has_many :challenges, through: :user_challenges, :uniq => true

  def total_points
    points.reduce(0) { |sum, p|  sum += p.amount }
  end

  def increase_points(value)
    Point.create(amount: value, user: self)
  end

  def decrease_points(value)
    Point.create(amount: value*-1, user: self)
  end

  private
  def init_redis
    RedisLeaderboard.get.rank_member(self.id, 0)
  end
end

