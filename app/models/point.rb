# == Schema Information
#
# Table name: points
#
#  id         :integer          not null, primary key
#  amount     :integer
#  user_id    :integer
#  decrease   :boolean          default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#

class Point < ActiveRecord::Base
  belongs_to :user
end
