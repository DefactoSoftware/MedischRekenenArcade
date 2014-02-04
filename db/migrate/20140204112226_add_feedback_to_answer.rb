class AddFeedbackToAnswer < ActiveRecord::Migration
   def change
    add_column :answers, :feedback, :string
  end
end
