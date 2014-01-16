class AddResultToProblem < ActiveRecord::Migration
  def change
    add_column :problems, :result, :float
  end
end
