class AddMaxDifficultyAndSkillOffsetToProblem < ActiveRecord::Migration
  def change
    add_column :problems, :max_difficulty, :integer, :default => 35
    add_column :problems, :skill_offset , :integer, :default => 10
  end
end
