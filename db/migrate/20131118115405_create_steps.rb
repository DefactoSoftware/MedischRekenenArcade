class CreateSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
      t.string :formula
      t.references :variables
      t.references :skills
      t.timestamps
    end
  end
end
