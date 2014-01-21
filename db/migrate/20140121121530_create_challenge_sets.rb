class CreateChallengeSets < ActiveRecord::Migration
  def change
    create_table :challenge_sets do |t|
      t.string :name
      t.boolean :locked
      t.timestamps
    end
  end
end
