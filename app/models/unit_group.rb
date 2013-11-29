# == Schema Information
#
# Table name: unit_groups
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class UnitGroup < ActiveRecord::Base
  has_many :units
end
