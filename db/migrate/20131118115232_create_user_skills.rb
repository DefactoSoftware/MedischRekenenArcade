class CreateUserSkills < ActiveRecord::Migration
  def change
    create_table :user_skills do |t|
      t.references :user
      t.references :skill
      t.float :level
      t.timestamps
    end
  end
end
