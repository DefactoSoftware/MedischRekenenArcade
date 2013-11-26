# == Schema Information
#
# Table name: user_groups
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class UserGroup < ActiveRecord::Base
  has_many :users
end
