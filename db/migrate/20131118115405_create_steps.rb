class CreateSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
      t.string :formula
      t.references :skill
      t.references :problem
      t.timestamps
    end
  end
end
