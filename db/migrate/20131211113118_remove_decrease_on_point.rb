class RemoveDecreaseOnPoint < ActiveRecord::Migration
  def change
    remove_column :points, :decrease
  end
end
