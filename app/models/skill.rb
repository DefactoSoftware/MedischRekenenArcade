# == Schema Information
#
# Table name: skills
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Skill < ActiveRecord::Base
  def self.get_random
    min = 0
    max = Skill.count
    Skill.all[rand(min...max)]
  end
end
