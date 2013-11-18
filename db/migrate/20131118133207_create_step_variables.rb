class CreateStepVariables < ActiveRecord::Migration
  def change
    create_table :step_variables do |t|
      t.references :step
      t.references :variable
      t.timestamps
    end
  end
end
