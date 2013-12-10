class CreateChallengeSkills < ActiveRecord::Migration
  def change
    create_table :challenge_skills do |t|
      t.references :skill
      t.references :challenge
      t.timestamps
    end
  end
end
