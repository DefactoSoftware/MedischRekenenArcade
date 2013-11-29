class AddUniqueIndexToUnit < ActiveRecord::Migration
  def change
    add_index :units, [:name], unique: true
    add_index :unit_groups, [:name], unique: true
  end
end
