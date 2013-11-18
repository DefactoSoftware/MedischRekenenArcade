# == Schema Information
#
# Table name: variables
#
#  id         :integer          not null, primary key
#  key        :string(255)
#  value      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Variable < ActiveRecord::Base
end
