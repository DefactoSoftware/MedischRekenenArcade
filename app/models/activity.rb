# == Schema Information
#
# Table name: activities
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  action         :string(255)
#  trackable_id   :integer
#  trackable_type :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  notified       :boolean          default(FALSE)
#

class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :trackable, polymorphic: true

  validates :user, presence: true
  validates :trackable, presence: true
  validates :action, presence: true
end
