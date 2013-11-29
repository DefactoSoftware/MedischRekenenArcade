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

  def self.increase(value=1, user)
    create(value:value, user: user)
  end

end
