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
  belongs_to :step
  belongs_to :user_skill

  def self.get_random
    min = 0
    max = Skill.count
    puts min
    puts max
    Skill.all[rand(min...max)]
  end
end
