class DropChallengeSkillTable < ActiveRecord::Migration
  def change
    drop_table :challenge_skills
  end
end
