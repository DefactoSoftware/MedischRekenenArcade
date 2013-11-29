class CreateUnitGroups < ActiveRecord::Migration
  def change
    create_table :unit_groups do |t|
      t.string :name
      t.timestamps
    end
  end
end
