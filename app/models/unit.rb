# == Schema Information
#
# Table name: units
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  sign          :string(255)
#  unit_group_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class Unit < ActiveRecord::Base
  belongs_to :unit_group
  belongs_to :problem
end
