class AddDefaultToUserSkillLevel < ActiveRecord::Migration
  def change
    change_column_default(:user_skills, :level, 0)
  end
end
