class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.integer :amount
      t.references :user
      t.boolean :decrease, default: false
      t.timestamps
    end
  end
end
