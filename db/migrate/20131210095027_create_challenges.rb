class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.integer :number_of_problems
      t.string :name
      t.integer :timelimit
      t.integer :bonus
      t.string :icon
      t.timestamps
    end

    add_index :challenges, :name, unique: true
  end
end
