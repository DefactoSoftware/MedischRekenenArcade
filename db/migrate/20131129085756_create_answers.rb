class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.float :value
      t.references :user
      t.references :problem
      t.timestamps
    end
  end
end
