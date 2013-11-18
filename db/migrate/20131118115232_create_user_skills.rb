class CreateUserSkills < ActiveRecord::Migration
  def change
    create_table :user_skills do |t|
      t.references :users
      t.references :skills
      t.float :level
      t.timestamps
    end
  end
end
