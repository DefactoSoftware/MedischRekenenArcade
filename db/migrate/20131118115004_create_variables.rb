class CreateVariables < ActiveRecord::Migration
  def change
    create_table :variables do |t|
      t.string :key
      t.string :value
      t.timestamps
    end
  end
end
