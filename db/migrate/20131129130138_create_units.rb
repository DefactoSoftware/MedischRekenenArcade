class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :name
      t.string :sign
      t.references :unit_group
      t.timestamps
    end
  end
end
