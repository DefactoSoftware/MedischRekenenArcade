class CreateSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
      t.references :skill
      t.references :problem
      t.float :value1
      t.float :value2
      t.string :symbol
      t.timestamps
    end
  end
end
