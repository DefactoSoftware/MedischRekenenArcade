class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.string :formula
      t.string :question
      t.string :theory
      t.float  :difficulty
      t.string :unit

      t.timestamps
    end
  end
end
